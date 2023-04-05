chatcolor_handler:
  type: world
  debug: false
  events:
    on player chats bukkit_priority:LOWEST:
    - determine passively cancelled

    - define prefix <player.chat_prefix.parse_color>
    - define name <player.name>
    - define recipients <context.recipients>
    - define color <player.flag[color]>
    - define message <context.message>


    - if <[color]> != rainbow:
      - narrate "<[prefix]><[name]>: <[color]><[message]>" targets:<[recipients]>
    - else:
      - narrate "<[prefix]><[name]>: <proc[chatcolor_rainbow].context[<[message]>]>" targets:<[recipients]>


    after player logs in flagged:!color:
    - flag <player> color:<&color[<color[white]>]>


chatcolor_command:
  name: chatcolor
  type: command
  debug: false
  description: Gives you a list of available colors to choose from.
  usage: /chatcolor [color]
  aliases:
  - cc
  permission: chatcolor.menu
  tab completions:
    1: <proc[chatcolor_tab]>
  script:
  - define valid_colors <list[white|silver|gray|black|red|maroon|yellow|olive|lime|green|aqua|teal|blue|navy|fuchsia|purple|orange|rainbow]>
  - if <context.args.is_empty> || !<context.args.contains_any[<[valid_colors]>]>:
    - narrate "<red>Invalid arguments."
  - else if !<player.has_permission[chatcolor.<context.args.first>]>:
    - narrate "<red>No permission."
  - else if <context.args.contains_any[rainbow]>:
    - narrate "<green>Chat color successfully set to <&1>r<&2>a<&3>i<&4>n<&5>b<&6>o<&7>w<&a>!"
    - flag <player> color:rainbow
  - else:
    - narrate "<green>Chat color successfully set to <&color[<color[<context.args.first>]>]><context.args.first><green>!"
    - flag <player> color:<&color[<color[<context.args.first>]>]>
    - stop



chatcolor_tab:
    type: procedure
    debug: false
    script:
    - define valid_colors <list[white|silver|gray|black|red|maroon|yellow|olive|lime|green|aqua|teal|blue|navy|fuchsia|purple|orange|rainbow]>
    - foreach <[valid_colors]>:
      - if <player.has_permission[chatcolor.<[value]>]>:
        - define list:->:<[value]>
    - determine <[list]>



chatcolor_rainbow:
    type: procedure
    debug: false
    definitions: message
    script:
    - define valid_colors <valid_colors.data_key[colors]>
    - foreach <[message].to_list> as:letter:
      - define final_message:->:<&color[<color[<[valid_colors].random>]>]><[letter]>
    - determine <[final_message].unseparated>

valid_colors:
    type: data
    colors: <list[white|silver|gray|black|red|maroon|yellow|olive|lime|green|aqua|teal|blue|navy|fuchsia|purple|orange]>