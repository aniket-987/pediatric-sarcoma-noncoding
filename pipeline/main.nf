nextflow.enable.dsl=2

log.info """\
    P E D I A T R I C   S A R C O M A   P I P E L I N E
    ===================================================
    genome       : ${params.genome}
    reads        : ${params.reads}
    outdir       : ${params.outdir}
    """
    .stripIndent()

process ALIGN_READS {
    tag "BWA on $sample_id"
    publishDir "${params.outdir}/aligned", mode: 'copy'

    input:
    tuple val(sample_id), path(reads)
    path genome

    output:
    tuple val(sample_id), path("${sample_id}.bam")

    script:
    """
    bwa mem -t ${task.cpus} ${genome} ${reads[0]} ${reads[1]} | samtools view -Sb - > ${sample_id}.bam
    """
}

process SORT_BAM {
    tag "Sort on $sample_id"
    publishDir "${params.outdir}/aligned", mode: 'copy'

    input:
    tuple val(sample_id), path(bam)

    output:
    tuple val(sample_id), path("${sample_id}.sorted.bam"), path("${sample_id}.sorted.bam.bai")

    script:
    """
    samtools sort -@ ${task.cpus} -o ${sample_id}.sorted.bam ${bam}
    samtools index ${sample_id}.sorted.bam
    """
}

workflow {
    read_pairs_ch = Channel.fromFilePairs(params.reads, checkIfExists: true)
    genome_ch = file(params.genome)

    ALIGN_READS(read_pairs_ch, genome_ch)
    SORT_BAM(ALIGN_READS.out)
}