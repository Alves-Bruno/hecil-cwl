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

