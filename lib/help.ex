defmodule Help do
  @moduledoc """
  Module for help.
  """

  def print_help do
    IO.puts """
                                    #{BColors.ok_green},----,
                                  ,/   .`|
        ,---,.   ,---,          ,`   .'  :
      ,'  .' |  '  .' \\       ;    ;     /
    ,---.'   | /  ;    '.   .'___,/    ,'
    |   |   .':  :       \\  |    :     |
    :   :  |-,:  |   /\\   \\ ;    |.';  ;
    :   |  ;/||  :  ' ;.   :`----'  |  |
    |   :   .'|  |  ;/  \\   \\   '   :  ;
    |   |  |-,'  :  | \\  \\ ,'   |   |  '
    '   :  ;/||  |  '  '--'     '   :  |
    |   |    \\|  :  :           ;   |.'
    |   :   .'|  | ,'           '---'
    |   | ,'  `--''
    `----'#{BColors.endc}\n
    #{BColors.header}A cat clone mixed with elixir magic 🔮#{BColors.endc}\n
    #{BColors.ok_blue}Usage: eat [options] [file ...]#{BColors.endc}\n
    #{BColors.bold}#{BColors.underline}Options:#{BColors.endc}
      #{BColors.ok_cyan}-h, --help  Show the help message.#{BColors.endc}
      #{BColors.ok_cyan}-b, --break-point <n> (n must be odd and bigger than 5) Set the break point.#{BColors.endc}
    """
  end
end
