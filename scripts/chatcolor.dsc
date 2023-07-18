chatcolor_handler:
  type: world
  debug: false
  events:
    on player chats bukkit_priority:LOWEST:
    - determine passively cancelled

    - define prefix <player.chat_prefix.parse_color.if_null[]>
    - define name <player.name>
    - define recipients <context.recipients>
    - define color <player.flag[chatcolor]>
    - define message <context.message>

    - if <[color]> != rainbow:
      - narrate "<[prefix]><[name]>: <[color]><[message]>" targets:<[recipients]>
    - else:
      - narrate "<[prefix]><[name]>: <[message].hex_rainbow>" targets:<[recipients]>

    after player joins flagged:!chatcolor:
    - flag <player> chatcolor:<&color[white]>

chatcolor_command:
  name: chatcolor
  type: command
  debug: false
  description: Gives you a list of available colors to choose from.
  usage: /chatcolor [color]
  aliases:
  - cc
  permission: chatcolor.command
  tab completions:
    1: <util.color_names.include[rainbow|gold].exclude[transparent].filter_tag[<player.has_permission[chatcolor.<[filter_value]>]>].include[reset]>
  script:
  - define valid_colors <util.color_names.include[rainbow|reset|gold].exclude[transparent]>
  - define args <context.args.first>

  - if <context.args.is_empty> || !<context.args.contains_any[<[valid_colors]>]>:
    - narrate "<&[error]>Invalid arguments."
  - else if !<player.has_permission[chatcolor.<[args]>]> && <[args]> != reset:
    - narrate "<&[error]>No permission."
  - else:
    - choose <[args]>:
      - case <[args]> == reset:
        - flag <player> chatcolor:<&color[white]>
        - narrate "<&a>Chat color reset to <&f>white<&a>!"
        - stop
      - case <[args]> == rainbow:
        - narrate "<&a>Chat color successfully set to <&1>r<&2>a<&3>i<&4>n<&5>b<&6>o<&7>w<&a>!"
        - flag <player> chatcolor:rainbow
      - case <[args]> == gold:
        - narrate "<&a>Chat color successfully set to <&6>gold<&a>!"
        - flag <player> chatcolor:<&color[gold]>
      - default:
        - narrate "<&a>Chat color successfully set to <&color[<color[<[args]>]>]><[args].to_lowercase><&a>!"
        - flag <player> chatcolor:<&color[<color[<[args]>]>]>
