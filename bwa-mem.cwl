#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.ref_fasta_files)
      - $(inputs.bwa)
      - $(inputs.ref_fasta)
      - $(inputs.query_fastq)
baseCommand: ['./bwa', 'mem', 'ref.fasta']

stdout: $(inputs.out_sam)
stderr: $(inputs.out_err)

inputs:
  bwa:
    type: File
  out_err:
    type: string
  out_sam:
    type: string
  query_fastq:
    inputBinding:
      position: 3
    type: File
  ref_fasta:
    type: File
  ref_fasta_files:
    type:
      items: File
      type: array
  
outputs:
  stde:
    type: stderr
  stdo:
    type: stdout
  
