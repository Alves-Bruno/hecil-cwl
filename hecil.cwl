#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow


inputs:
  Correction_py:
    type: File
  Create_Corrected_All_Reads:
    type: File
  Create_SubsetPileup:
    type: File
  Split_Pileup:
    type: File
  bwa:
    type: File
  corr_out:
    type: File
  fasta_reduce_file:
    type: File
  fastq_reduce:
    type: File
  out_bam_file:
    type: File
  out_err_0:
    type: string
  out_err_1:
    type: string
  out_err_2:
    type: string
  out_err_3:
    type: string
  out_err_4:
    type: string
  out_sam_0:
    type: string
  out_sam_1:
    type: string
  out_sam_2:
    type: string
  out_sam_3:
    type: string
  out_sam_4:
    type: string
  out_sam_file:
    type: File
  query_fastq:
    type: File
  query_fastq_0:
    type: File
  query_fastq_1:
    type: File
  query_fastq_2:
    type: File
  query_fastq_3:
    type: File
  query_fastq_4:
    type: File
  ref_fasta:
    type: File
  ref_fasta_out:
    type: File[]
  sam_cat_file:
    type: File
  samtools:
    type: File
  
outputs:
  cat_all_stderr:
    outputSource: sam_cat_err/stdo
    type: File
  cat_all_stdout:
    outputSource: sam_cat/stdo
    type: File
  
steps:
  bwa_index:
    run: bwa-index.cwl
    in:
      bwa: bwa
      ref_fasta: ref_fasta
    out: [stdo, stde, ref_fasta_out]

  perl:
    run: perl.cwl
    in:
      fastq_reduce: fastq_reduce
      query_fastq: query_fastq
    out: [stdout, stde, query_fastq_0, query_fastq_1, query_fastq_2, query_fastq_3, query_fastq_4]

  bwa_mem_0:
    run: bwa-mem.cwl
    in:
      bwa: bwa
      ref_fasta_files: ref_fasta_out
      ref_fasta: ref_fasta
      query_fastq: query_fastq_0
      out_sam: out_sam_0
      out_err: out_err_0
    out: [stdo, stde]

  bwa_mem_1:
    run: bwa-mem.cwl
    in:
      bwa: bwa
      ref_fasta_files: ref_fasta_out
      ref_fasta: ref_fasta
      query_fastq: query_fastq_1
      out_sam: out_sam_1
      out_err: out_err_1
    out: [stdo, stde]

  bwa_mem_2:
    run: bwa-mem.cwl
    in:
      bwa: bwa
      ref_fasta_files: ref_fasta_out
      ref_fasta: ref_fasta
      query_fastq: query_fastq_2
      out_sam: out_sam_2
      out_err: out_err_2
    out: [stdo, stde]

  bwa_mem_3:
    run: bwa-mem.cwl
    in:
      bwa: bwa
      ref_fasta_files: ref_fasta_out
      ref_fasta: ref_fasta
      query_fastq: query_fastq_3
      out_sam: out_sam_3
      out_err: out_err_3
    out: [stdo, stde]

  bwa_mem_4:
    run: bwa-mem.cwl
    in:
      bwa: bwa
      ref_fasta_files: ref_fasta_out
      ref_fasta: ref_fasta
      query_fastq: query_fastq_4
      out_sam: out_sam_4
      out_err: out_err_4
    out: [stdo, stde]

  sam_cat:
    run: sam-cat.cwl
    in:
      sam_cat_file: sam_cat_file
      Out_0_sam: bwa_mem_0/stdo
      Out_1_sam: bwa_mem_1/stdo
      Out_2_sam: bwa_mem_2/stdo
      Out_3_sam: bwa_mem_3/stdo
      Out_4_sam: bwa_mem_4/stdo
    out: [stdo]

  sam_cat_err:
    run: sam-cat-err.cwl
    in:
      mem_0_err: bwa_mem_0/stde
      mem_1_err: bwa_mem_1/stde
      mem_2_err: bwa_mem_2/stde
      mem_3_err: bwa_mem_3/stde
      mem_4_err: bwa_mem_4/stde
    out: [stdo]

  sam_tools_view:
    run: samtools-view.cwl
    in:
      samtools: samtools
      Out_sam: out_sam_file
    out: [Out_bam, stde]

  samtools_mpileup:
    run: samtools-mpileup.cwl
    in:
      samtools: samtools
      Out_bam: out_bam_file
      ref_fasta: ref_fasta
    out: [ref_fasta_fai, stde, stdo]

  split_pileup:
    run: split-pileup.cwl
    in:
      pileup_txt: samtools_mpileup/stdo
      Split_Pileup: Split_Pileup
      Create_SubsetPileup: Create_SubsetPileup
    out: [Pileup_Set1, Pileup_Set2, stde]

  correction_0:
    run: correction.cwl
    in:
      Correction_py: Correction_py
      Pileup_set: split_pileup/Pileup_Set1
      ref_fasta: ref_fasta
      Out_sam: out_sam_file
    out: [lc_out, stde, stdo]

  correction_1:
    run: correction.cwl
    in:
      Correction_py: Correction_py
      Pileup_set: split_pileup/Pileup_Set2
      ref_fasta: ref_fasta
      Out_sam: out_sam_file
    out: [lc_out, stde, stdo]

  add_line_0:
    run: add_line.cwl
    in:
      lc: correction_0/lc_out
      corr_err: correction_0/stde
    out: [lc_out, corr_err_out]

  add_line_1:
    run: add_line.cwl
    in:
      lc: correction_1/lc_out
      corr_err: correction_1/stde
    out: [lc_out, corr_err_out]

  cat_corr_out:
    run: catcorr.out.cwl
    in:
      corr_0: correction_0/stdo
      corr_1: correction_1/stdo
    out: [stdo]

  cat_corr_err:
    run: catcorr.err.cwl
    in:
      corr_0: add_line_0/corr_err_out
      corr_1: add_line_1/corr_err_out
    out: [stdo]

  cat_lc_out:
    run: catLowConf.txt.cwl
    in:
      corr_0: add_line_0/lc_out
      corr_1: add_line_1/lc_out
    out: [stdo]

  fasta_reduce:
    run: fasta_reduce.cwl
    in:
      fasta_reduce: fasta_reduce_file
      ref_fasta: ref_fasta
    out: [ref_fasta_0, ref_fasta_1, ref_fasta_2, ref_fasta_3, ref_fasta_4]

  correct_all_reads_0:
    run: correc_all_reads.cwl
    in:
      Create_Corrected_All_Reads: Create_Corrected_All_Reads
      ref_fasta_i: fasta_reduce/ref_fasta_0
      corr_out: corr_out
    out: [stde]

  correct_all_reads_1:
    run: correc_all_reads.cwl
    in:
      Create_Corrected_All_Reads: Create_Corrected_All_Reads
      ref_fasta_i: fasta_reduce/ref_fasta_1
      corr_out: corr_out
    out: [stde]

  correct_all_reads_2:
    run: correc_all_reads.cwl
    in:
      Create_Corrected_All_Reads: Create_Corrected_All_Reads
      ref_fasta_i: fasta_reduce/ref_fasta_2
      corr_out: corr_out
    out: [stde]

  correct_all_reads_3:
    run: correc_all_reads.cwl
    in:
      Create_Corrected_All_Reads: Create_Corrected_All_Reads
      ref_fasta_i: fasta_reduce/ref_fasta_3
      corr_out: corr_out
    out: [stde]

  correct_all_reads_4:
    run: correc_all_reads.cwl
    in:
      Create_Corrected_All_Reads: Create_Corrected_All_Reads
      ref_fasta_i: fasta_reduce/ref_fasta_4
      corr_out: corr_out
    out: [stde]

