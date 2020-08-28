#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.samtools)
      - $(inputs.Out_sam)
baseCommand: ['./samtools', 'view', '-bS', 'Out.sam', '|', './samtools', 'sort', '-', 'Out']

stderr: sort.err

inputs:
  Out_sam:
    type: File
  samtools:
    type: File
  
outputs:
  Out_bam:
    outputBinding:
      glob: "Out.bam"
    type: File
  stde:
    type: stderr
  
