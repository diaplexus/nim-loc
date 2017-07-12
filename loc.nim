import parsecfg, parseopt


proc writeHelp() =
  echo """Usage: loc <ini_section>

  -h --help       Print this help.
  -v --version    Print the version number.
  """
  quit(0)


proc writeVersion() =
  echo "Version: 0.0.1"
  quit(0)


proc printCommentSymbols(section: string) =
  var dict = loadConfig("language_comment_styles.ini")
  var single_line = dict.getSectionValue(section, "single_line")
  var block_start = dict.getSectionValue(section, "block_start")
  var block_end = dict.getSectionValue(section, "block_end")

  echo "Single Line: ", single_line
  echo "Block Start: ", block_start
  echo "Block End:   ", block_end


proc main() =
  var section = ""

  for kind, key, val in getopt():
    case kind
    of cmdArgument:
      section = key
    of cmdLongOption, cmdShortOption:
      case key
      of "help", "h": writeHelp()
      of "version", "v": writeVersion()
    of cmdEnd: assert(false) # cannot happen

  if section == "":
    # no filename has been given, so we show the help:
    writeHelp()

  printCommentSymbols(section)


main()
