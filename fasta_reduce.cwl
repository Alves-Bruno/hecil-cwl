#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fasta_reduce)
      - $(inputs.ref_fasta)
baseCommand: ['./fasta_reduce', 'ref.fasta', '1000']


inputs:
  fasta_reduce:
    type: File
  ref_fasta:
    type: File
  
outputs:
  ref_fasta_0:
    outputBinding:
      glob: "ref.fasta.0"
    type: File
  ref_fasta_1:
    outputBinding:
      glob: "ref.fasta.1"
    type: File
  ref_fasta_2:
    outputBinding:
      glob: "ref.fasta.2"
    type: File
  ref_fasta_3:
    outputBinding:
      glob: "ref.fasta.3"
    type: File
  ref_fasta_4:
    outputBinding:
      glob: "ref.fasta.4"
    type: File
  
