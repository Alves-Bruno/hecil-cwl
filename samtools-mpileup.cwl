#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.samtools)
      - $(inputs.Out_bam)
      - $(inputs.ref_fasta)
baseCommand: ['./samtools', 'mpileup', '-s', '-f', 'ref.fasta', 'Out.bam']

stdout: pileup.txt
stderr: pileup.err

inputs:
  Out_bam:
    type: File
  ref_fasta:
    type: File
  samtools:
    type: File
  
outputs:
  ref_fasta_fai:
    outputBinding:
      glob: "ref.fasta.fai"
    type: File
  stde:
    type: stderr
  stdo:
    type: stdout
  
