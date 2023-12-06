inventory_cost_display:
  type: world
  debug: false
  events:
    #
    ### This is not drag-and-drop! The script is a simple proof of concept, an example if you will.
    #
    on player opens inventory:
      - foreach <player.inventory.map_slots> as:item:
        - if <[item].has_flag[cost]>:
          - if <[item].has_lore>:
            - define lore <[item].lore>
          - else:
            - define lore <list>
          - define new_lore <[lore].include[<green>Cost:<&sp>$<[item].flag[cost]>]>
          - inventory adjust slot:<[key]> lore:<[new_lore]>

    on player closes inventory:
      - foreach <player.inventory.map_slots> as:item:
        - if <[item].has_flag[cost]>:
          - if <[item].has_lore>:
            - define lore <[item].lore>
          - else:
            - define lore <list>
          - define new_lore <[lore].exclude[<green>Cost:<&sp>$<[item].flag[cost]>]>
          - inventory adjust slot:<[key]> lore:<[new_lore]>
