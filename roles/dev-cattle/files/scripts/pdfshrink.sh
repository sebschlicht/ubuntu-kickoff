#!/bin/bash
# Return Codes:
# * 10: target is a file, but source is a directory
#
PROGRAM_NAME='pdfshrink'
PROGRAM_TITLE='PDF Shrinking Skript'
QUIET=false

#################################
# variable initialization section 
#################################
DEFAULT_RESOLUTION=72
SUPPORTED_LEVELS=( low medium high )
SOURCE=
TARGET=
RESOLUTION=

# Prints the usage of the script in case of using the help command.
printUsage () {
  echo 'Usage: '"$PROGRAM_NAME"' [OPTIONS] SOURCE TARGET [RESOLUTION]'
  echo
  echo 'Shrinks a PDF file to reduce its size.'
  echo "The desired resolution is passed as DPI value (default: $DEFAULT_RESOLUTION)."
  echo 'You may pass a directory as source to process all its files, non-recursively.'
  echo
  echo 'Options:'
  echo '-h, --help  Display this help message and exit.'
  echo '-q, --quiet Suppress any output.'
}

# Echoes an error message to stderr.
fc_error () {
  if [ "$QUIET" = false ]; then
    >&2 echo -e "[ERROR] $1"
  fi
}
# Echoes a warning to stderr.
fc_warn () {
  if [ "$QUIET" = false ]; then
    >&2 echo -e "[WARN] $1"
  fi
}
# Echoes an info message to stdout.
fc_info () {
  if [ "$QUIET" = false ]; then
    echo -e "[INFO] $1"
  fi
}

# Parses the startup arguments into variables.
parseArguments () {
  while [[ $# > 0 ]]; do
    key="$1"
    case $key in
      # help
      -h|--help)
      printUsage
      exit 0
      ;;
      # quiet mode
      -q|--quiet)
      QUIET=true
      ;;
      # unknown option
      -*)
      fc_error "Unknown option '$key'!"
      return 2
      ;;
      # parameter
      *)
      if ! handleParameter "$1"; then
        fc_error 'Too many arguments!'
        return 2
      fi
      ;;
    esac
    shift
  done
  
  # check for valid number of parameters
  if [ -z "$SOURCE" ] || [ -z "$TARGET" ]; then
    fc_error 'Too few arguments!'
    return 2
  fi
  
  ##########################
  # check parameter validity
  ##########################
  # when processing a directory (source) make sure to have a target directory
  if [ ! -d "$TARGET" ] && [ -d "$SOURCE" ]; then
    fc_error 'You may not specify a single target file when processing a directory!'
    return 10
  fi
  # check if the resolution is within the valid range
  if [ -z "$RESOLUTION" ]; then
    RESOLUTION="${DEFAULT_RESOLUTION}"
  fi
}

# Handles the parameters (arguments that aren't an option) and checks if their count is valid.
handleParameter () {
  # 1. parameter: source file/directory
  if [ -z "$SOURCE" ]; then
    SOURCE="${1}"
  # 2. parameter: target file/directory
  elif [ -z "$TARGET" ]; then
    TARGET="${1}"
  # optional 3. parameter: resolution
  elif [ -z "$RESOLUTION" ]; then
    RESOLUTION="${1}"
  else
    # too many parameters
    return 1
  fi
}

##############################
# main script function section
##############################

# Shrinks a PDF file to the desired quality level using GhostScript.
fc_gsshrink () {
  local source="$1"
  local target="$2"
  local resolution="$3"
  local device='screen'

  # was 1.3
  gs					\
	  -q -dNOPAUSE -dQUIET -dBATCH -dSAFER		\
	  -sDEVICE=pdfwrite			\
	  -dCompatibilityLevel=1.4		\
	  -dPDFSETTINGS=/"$device"			\
	  -dEmbedAllFonts=true			\
	  -dSubsetFonts=true			\
	  -dAutoRotatePages=/None		\
	  -dColorImageDownsampleType=/Bicubic	\
	  -dColorImageResolution=$resolution		\
	  -dGrayImageDownsampleType=/Bicubic	\
	  -dGrayImageResolution=$resolution		\
	  -dMonoImageDownsampleType=/Subsample	\
	  -dMonoImageResolution=$resolution		\
	  -sOutputFile="$target"			\
	  "$source"
}

#############
# entry point
#############
parseArguments "$@"
SUCCESS=$?
if [ "$SUCCESS" -ne 0 ]; then
  fc_error "Use the '-h' switch for help."
  exit "$SUCCESS"
fi

# execute main script functions

SOURCES=()
if [ -f "$SOURCE" ]; then
  # single source file
  SOURCES+=("$SOURCE")
else
  # scan source directory
  for f in "${SOURCE%/}/*"; do
    SOURCES+=("$f")
  done
fi

for s in $SOURCES; do
  # determine concrete target file
  FTARGET="$TARGET"
  if [ -d "$TARGET" ]; then
    FTARGET="${TARGET%/}/${s##*/}"
  fi

  # shrink PDF file
  fc_gsshrink "$s" "$FTARGET" "$RESOLUTION"
done
