# genome assembly
ls > ../list.txt
list=$(cat ../list.txt)
for i in ${list};do
	cd ${list};
	spades -o spades_result -1 *_R1.fq.gz -2 *_R2.fq.gz -t 30;
	cd ..;
done

# genome accessing and single copy gene extracting
conda activate buscoEnv-py3.7
for i in $list;do
	cd ${i};
	time busco -i ./spades_result/scaffolds.fasta -o busco -m geno -c 16 -l /run/media/dell/data/agaricales_odb10 --offline -f;
	cd ..;
done
conda deactivate

# statistify gene frequency
dos2unix list2.txt
list=$(cat list.txt)
list2=$(cat list2.txt)
for i in $list2;do
    echo -ne "${i}\t" >> test.txt;
    find ./*/busco/run_agaricales_odb10/busco_sequences/single_copy_busco_sequences -name "${i}.faa"| wc -l >> genespe.txt;
done

# alignment
dos2unix list2.txt
list2=$(cat list2.txt)
for i in $list2;do
    for j in $list;do
        echo ">${j}" >> ./all/${i}.fasta;
        grep -v ">" ./${j}/busco/run_agaricales_odb10/busco_sequences/single_copy_busco_sequences/${i}.faa >> ./all/${i}.fasta;
    done
done

for i in *.fasta;do
	linsi --thread 20 ${i} > ${i}.mafft;
done

for i in *.mafft;do
	Gblocks $i -b4=2 -b5=h -t=p;
done

for i in *.mafft-gb;do
    seqkit sort $i > $i.sort;
done

paste -d " " *.seqkit > all.fa

# modeltest
java -jar prottest-3.4-2/prottest-3.4.2.jar -i  /mnt/d/Amanita/all/all.fa -all-distributions -F -AIC -BIC -tc 0.5 -threads 20 -o  /mnt/d/Amanita/all/prottest.out

# raxml 
raxmlHPC-PTHREADS-SSE3 -T 20 -f a -x 123 -p 123 -N 1000 -m PROTGAMMAIJTTF -k -O -n all.tre -s all.fa
# iqtree
iqtree -s all.fasta -m MFP -bb 1000 -nt 20