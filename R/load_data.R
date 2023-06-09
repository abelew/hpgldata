## Set up some datasets/variables for working with the examples/tests/vignettes.

#' Get the filenames of the Streptococcus pyogenes strain 5005 data.
#'
#' This should return the Group A Streptococcus pyogenes strain 5005 GFF file,
#' fasta genome, and some count tables. The gff contains the annotations which
#' correspond to NC_007297.  The rda file contains an expt which comprises a
#' subset of a RNASeq experiment performed with the McIver lab.  The goal was
#' to examine changes in transcription across two media types (the very
#' permissive THY and restrictive CDM).  In addition, this used two strains,
#' one which is more and less pathogenic.
#'
#' @export
get_spyogenes_data <- function() {
  retlist <- list(
    "gff" =  system.file("share", "gas.gff", package = "hpgldata"),
    "fasta" = system.file("share", "spyogenes_5005.fasta", package = "hpgldata"),
    "expt" =  system.file("share", "cdm_expt.rda", package = "hpgldata")
  )
  return(retlist)
}

#' Pseudomonas areuginosa strain PA14 data files.
#'
#' The sample sheet from an experiment with another ESKAPE pathogen,
#' Pesudomonas!  This is emblematic of how I like to organize samples.  The most
#' relevant columns for creating an expressionset with create_expt() include:
#' 'Sample ID', 'Condition', 'Batch', and 'file'.  This actually provides a
#' subset of an experiment in which we were looking simultaneously at the
#' 'large' and 'small' RNA populations in two PA strains, one of which is
#' deficient in an oligonucleotide degradation enzyme 'orn'.  We were also
#' seeking to find changes from exponential growth to stationary.  The portions
#' of the experiment included in this sample sheet are only 3 replicates of the
#' large RNA samples.  The gff and fasta correspond to the genome and
#' annotations used when mapping and may be recreated with the accompanying
#' genbank flat file.  Finally, 'counts' contains the count directory from the
#' Pseudomonas experiment subset, which is an archive file containing the raw
#' tables created via bowtie2 -> samtools -> htseq-count.
#'
#' @export
get_paeruginosa_data <- function() {
  retlist <- list(
    "sample_sheet" = system.file("share", "pa_samples.xlsx", package = "hpgldata"),
    "gff" = system.file("share", "paeruginosa_pa14.gff", package = "hpgldata"),
    "fasta" = system.file("share", "paeruginosa_pa14.fasta", package = "hpgldata"),
    "gb" = system.file("share", "paeruginosa.pa14.gb", package = "hpgldata"),
    "counts" = system.file("share", "counts", package = "hpgldata")
  )
  return(retlist)
}

#' Subset of a human RNASeq expressionset.
#'
#' This is a portion of an expressionset used to examine changes caused by
#' infection with Leishmania panamensis.
#'
#' @export
get_hsapiens_data <- function() {
  retlist <- list(
    "expt" =  system.file("share", "hs_expt.rda", package = "hpgldata")
  )
  return(retlist)
}

#' Extra fonts and useful bits and bobs for working with circos.
#'
#' This is a tarball of the circos etc/ directory from my Debian linux
#' installation.  I discovered to my annoyance that other systems were missing
#' the fonts required to make circos plots work properly along with something
#' else.  In a fit of pique I tarred them up and left them here.
#'
#' @export
get_circos_data <- function() {
  circos_etc <- system.file("share", "circos", "circos_etc.tar.xz", package = "hpgldata")
  return(circos_etc)
}

#' Sample sheet from a portion of an RNASeq experiment of Trypanosoma cruzi CL-Brener.
#'
#' This contains a portion of an experiment performed with Santuza in which we
#' were comparing two closely related T.cruzi strains: CL-14 and CL-Brener,
#' which are super-similar but vastly different in terms of their
#' pathogenicity.  (I would much rather be infected with CL-14!).  The count
#' tables were created via TopHat2 mapping of the CL-Br and CL-14 samples
#' using the CL-Brener genome.  One of the interesting and bizarre things about
#' CL-Brener: it is a multi-haplotype strain, containing bits and pieces from
#' two lineages, named 'Esmeraldo' and 'Non-Esmeraldo'.  In addition, there is a
#' large portion which has not been characterized and is therefore called
#' 'Unassigned'.  Thus, when mapping the data, we create a concatenated genome
#' with all three haplotypes.  One thing we did not include in the paper
#' (because I didn't think of it until later), was an analysis of the single
#' nucleotide variants between the two strains.  RNASeq data is of course not an
#' ideal format for performing these analyses, but I think I figured out a
#' reasonable method to extract mostly robust differences (in snp.r).
#'
#' @export
get_tcruzi_data <- function() {
  retlist <- list(
    "sample_sheet" = system.file("share", "clbr", "clbr_samples_combined.xlsx",
                                 package = "hpgldata"),
    "count_tables" = system.file("share", "clbr", "clbr_counts.tar.xz", package = "hpgldata"),
    "gff" = system.file("share", "clbr", "clbrener_8.1_complete_genes.gff.gz",
                        package = "hpgldata"),
    "vcf_data" = system.file("share", "clbr", "vcfutils_output.tar.xz",
                             package = "hpgldata")
  )
  return(retlist)
}

#' Sample sheet used for a portion of a Group B Streptococcal TNSeq experiment.
#'
#' TNSeq is sort of the inverse of RNASeq, one is instead looking for the genes
#' _not_ represented in the dataset.  This sample sheet lays out the
#' experimental design for an in vitro TNSeq experiment from Streptococcus
#' agalactiae strain CJB111.  At the time of the experiment, there was not a
#' very good genome for this strain.  We therefore chose to use strain A909 as
#' the reference.  Since then, Lindsey's lab made a complete genome, though the
#' annotations remain a bit sparse.  One thing I like to do with TNSeq data
#' is to treat it similarly to RNASeq data in order to get a sense of the
#' changing 'fitness' of each gene.  The data has all the same distribution
#' attributes of a RNASeq dataset, after all; so why not use the same plots and
#' tests to see if it is valid?  The Essentiality package from the DeJesus lab
#' uses a Bayesian framework to look for genes which are essential in a TNSeq
#' experiment.  In my pipeline, I invoke this tool with multiple parameters in
#' an attempt to find the parameters which provide the most likely 'true'
#' result.  This archive contains those results for our GBS TNSeq experiment.
#' My preprocessing pipeline uses the bam alignments from bowtie to extract all
#' reads which start/end on a mariner insertion site (TA) and count how many
#' occured at every position of the genome.  These files are the result of that
#' process, thus each line is the position of a 'T' in the 'TA' followed by the
#' number of reads which start/end with it.
#'
#' @export
get_sagalactiae_data <- function() {
  retlist = list(
    "sample_sheet" = system.file("share", "gbs_tnseq", "sagalactiae_samples.xlsx",
                                 package = "hpgldata"),
    "gff" = system.file("share", "gbs_tnseq", "sagalactiae_a909.gff",
                        package = "hpgldata"),
    "fasta" = system.file("share", "gbs_tnseq", "sagalactiae_a909.fasta",
                          package = "hpgldata"),
    "count_tables" = system.file("share", "gbs_tnseq", "gbs_essentiality_counts.tar.xz",
                                 package = "hpgldata"),
    "essentiality_in" = system.file("share", "gbs_tnseq", "gbs_essentiality_wig.tar.xz",
                                    package = "hpgldata"),
    "essentiality_out" = system.file("share", "gbs_tnseq", "gbs_essentiality.tar.xz",
                                     package = "hpgldata")
  )
  return(retlist)
}

#' The UTR regions of every highly translated L.major gene.
#'
#' Once upon a time I performed a ribosome profiling experiment in Leishmania
#' major.  Sadly, we still have not published it.  This file contains the UTRs
#' of every highly translated gene in procyclic promastigotes.  I used it in
#' some motif analyses for fun.
#'
#' @export
get_lmajor_data <- function() {
  retlist = list(
    "utrs" = system.file("share", "motif", "pro_high.fasta",
                         package = "hpgldata")
  )
  return(retlist)
}

#' Portion of a sample sheet used in a DIA-SWATH proteomics experiment.
#'
#' In this experiment, Dr. Briken sought to learn about proteins which are
#' exported by Mycobacterium tuberculosis.  He therefore performed a DIA SWATH
#' experiment using two strains and collected the supernatant fraction (to get
#' the exported proteins) and the intracellular fraction.  This file contains
#' the metadata for a portion of that experiment.  I used a fairly exhaustive
#' set of open source tools to interpret Dr. Briken's data.  These files
#' comprise the endpoint of the preprocessing and the inputs for the R package
#' 'SWATH2stats'.  This file is excessively large, but the smallest by far of
#' the various inputs I wanted to include to test my various proteomics functions.
#' In a separate series of experiments, we sought to look at the effect of
#' infection on splicing in the host.  Thus I performed rmats and suppa and
#' attempted to compare the results to see how reliable they are.  (spoiler: not very).
#'
#' @export
get_mtuberculosis_data <- function() {
  retlist <- list(
    "dia_sample_sheet" = system.file("share", "mtb_prot", "dia_samples.ods",
                                     package = "hpgldata"),
    "dia_counts" = system.file("share", "mtb_prot", "sb_prot.tar.xz", package = "hpgldata"),
    "rmats_out" = system.file("share", "mtb_rmats.tar.xz", package = "hpgldata"),
    "suppa_out" = system.file("share", "mtb_suppa.tar.xz", package = "hpgldata")
  )
  return(retlist)
}

#' Portion of the RNASeq results from Solanum betaceum.
#'
#' I had the opportunity to work the Sandra Correia, she was awesome.  She was
#' seeking to learn about differences among embryogenic cells in the Tree
#' tomato.  I therefore got to learn first-hand a tiny portion of what is meant
#' when one says 'plant genetics are hard.'  I had it far easier than Sandra.  I
#' just used Trinity to make some de-novo transcriptomes and attempt to provide
#' some metrics about which ones are real and really different across conditions
#' in her experiment.  Her work was many thousands of times more difficult.  The
#' full S.betaceum trinotate annotation is quite large, so I just pulled a
#' portion as an example for this package.
#'
#' @export
get_sbetaceum_data <- function() {
  retlist <- list(
    "counts" = system.file("share", "sb", "preprocessing.tar.xz", package = "hpgldata"),
    "annot" = system.file("share", "sb", "trinotate_head.csv.xz", package = "hpgldata")
  )
  return(retlist)
}
