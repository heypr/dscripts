chatcolor_handler:
  type: world
  debug: false
  events:
    on player chats bukkit_priority:LOWEST:
    - determine passively cancelled

    - define prefix <player.chat_prefix.parse_color.if_null[<empty>]>
    - define color <player.flag[chatcolor].if_null[<&color[white]>]>
    - define message <context.message>

    - if !<player.has_flag[chatcolor]>:
      - flag <player> chatcolor:<&color[white]>

    - if <[color]> != rainbow:
      - define message "<[prefix]><player.name>: <[color]><[message]>"
    - else:
      - define message "<[prefix]><player.name>: <[message].hex_rainbow>"

    - narrate <[message]> targets:<context.recipients>
    after player joins flagged:!chatcolor:
    - flag <player> chatcolor:<&color[white]>

chatcolor_command:
  name: chatcolor
  type: command
  debug: false
  description: Lets you change your chat color.
  usage: /chatcolor [color]
  aliases:
  - cc
  permission: chatcolor.command
  tab completions:
    1: <util.color_names.include[rainbow|gold|hex].exclude[transparent].filter_tag[<player.has_permission[chatcolor.<[filter_value]>]>].include[reset]>
  ### The "reset" tab complete option is not included in the filter as you shouldn't need permission to reset your chat color.
  script:
  - define valid_colors <util.color_names.include[rainbow|reset|gold|hex].exclude[transparent]>
  - define color <context.args.first.if_null[<empty>]>
  - define hex <context.args.get[2].if_null[<empty>]>

  - if <context.args.is_empty> || !<context.args.contains_any[<[valid_colors]>]>:
    - narrate "<&[error]>Invalid arguments."
    - stop
  - if !<player.has_permission[chatcolor.<[color]>]> && <[color]> != reset:
    - narrate "<&[error]>No permission."
    - stop
  - choose <[color]>:
    - case reset:
      - flag <player> chatcolor:<&color[white]>
      - narrate "<&a>Chat color reset to <&f>white<&a>!"
      - stop
    - case rainbow:
      - narrate "<&a>Chat color successfully set to <element[rainbow].hex_rainbow><&a>!"
      - flag <player> chatcolor:rainbow
    - case gold:
      - narrate "<&a>Chat color successfully set to <&6>gold<&a>!"
      - flag <player> chatcolor:<&color[gold]>
    - case hex:
      - if <[hex].regex_matches[#(?:[0-9a-fA-F]{6}){1,2}]>:
        - narrate "<&a>Chat color successfully set to <&color[<[hex]>]><[hex].to_lowercase><&a>!"
        - flag <player> chatcolor:<&color[<color[<[hex]>]>]>
      - else:
        - narrate "<&[error]>Invalid hex color provided."
    - default:
      - narrate "<&a>Chat color successfully set to <&color[<color[<[color]>]>]><[color].to_lowercase><&a>!"
      - flag <player> chatcolor:<&color[<color[<[color]>]>]>