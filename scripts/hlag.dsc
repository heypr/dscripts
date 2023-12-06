hLag:
  type: world
  debug: false
  events:
    on delta time minutely every:15:
    - define prefix <script[hLag_prefix].parsed_key[prefix]>
    - define message "<&r>Dropped entities will be cleared in "
    - announce "<[prefix]> <[message]> <red>5 minutes!"
    - wait 5m
    - announce "<[prefix]> <[message]> <red>30 seconds!"
    - wait 30s
    - announce "<[prefix]> <[message]> <red>10 seconds!"
    - wait 5s
    - announce "<[prefix]> <[message]> <red>5 seconds!"
    - wait 1s
    - announce "<[prefix]> <[message]> <red>4 seconds!"
    - wait 1s
    - announce "<[prefix]> <[message]> <red>3 seconds!"
    - wait 1s
    - announce "<[prefix]> <[message]> <red>2 seconds!"
    - wait 1s
    - announce "<[prefix]> <[message]> <red>1 second!"
    - wait 1s
    - define entities
    - foreach <server.worlds> as:world:
      - foreach <[world].entities[Arrow|DROPPED_ITEM]>:
        - define entities:++
      - remove Arrow|DROPPED_ITEM world:<[world]>
    - announce "<[prefix]> <green><[entities].if_null[0]> entities have been cleared!"

hLag_prefix:
  type: data
  prefix: <red>[<&2>Prefix<&sp><&6>Here<red>]
