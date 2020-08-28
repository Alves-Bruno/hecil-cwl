#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.bwa)
      - $(inputs.ref_fasta)
baseCommand: ['./bwa', 'index']

stdout: bwa-index.out
stderr: bwa-index.err

inputs:
  bwa:
    type: File
  ref_fasta:
    inputBinding:
      position: 2
    type: File
  
outputs:
  ref_fasta_out:
    outputBinding:
      glob: "ref.fasta.*"
    type:
      items: File
      type: array
  stde:
    type: stderr
  stdo:
    type: stdout
  
