return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 48,
  height = 32,
  tilewidth = 24,
  tileheight = 24,
  backgroundcolor = { 238, 238, 238 },
  properties = {},
  tilesets = {
    {
      name = "tileset",
      firstgid = 1,
      tilewidth = 24,
      tileheight = 24,
      spacing = 0,
      margin = 0,
      image = "../gfx/tileset.png",
      imagewidth = 96,
      imageheight = 48,
      transparentcolor = "#ff00ff",
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "imagelayer",
      name = "Paralax1",
      visible = true,
      opacity = 1,
      image = "../gfx/background.jpg",
      properties = {}
    },
    {
      type = "tilelayer",
      name = "Background",
      x = 0,
      y = 0,
      width = 48,
      height = 32,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 6, 0, 5, 3, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 3, 6, 0, 5, 3,
        3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 3,
        3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 3,
        3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 6, 5, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 3,
        3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 5, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 3,
        3, 0, 0, 0, 3, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 3, 0, 0, 0, 3,
        3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 3,
        3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 6, 5, 2, 0, 0, 1, 6, 0, 0, 0, 5, 6, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 3,
        3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 5, 2, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 3,
        3, 0, 0, 0, 3, 6, 0, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 0, 0, 5, 3, 0, 0, 0, 3,
        3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 3,
        3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 5, 6, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 3,
        3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 3, 0, 0, 0, 3,
        3, 0, 0, 0, 3, 6, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 0, 5, 6, 0, 0, 0, 0, 5, 2, 0, 0, 0, 5, 3, 0, 0, 0, 3,
        3, 0, 0, 0, 6, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 5, 0, 0, 0, 3,
        3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3,
        3, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3,
        3, 3, 2, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 0, 0, 1, 3, 3,
        3, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 3,
        3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3,
        3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3,
        3, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 3,
        3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3,
        3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3,
        3, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 3,
        3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3,
        3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3,
        3, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 3,
        3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3,
        3, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
      }
    },
    {
      type = "objectgroup",
      name = "BackColider",
      visible = false,
      opacity = 1,
      properties = {
        ["collidable"] = "true"
      },
      objects = {
        {
          name = "",
          type = "",
          shape = "polyline",
          x = 24,
          y = 48,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 24, y = -24 },
            { x = 48, y = -24 },
            { x = 72, y = 0 },
            { x = 72, y = 336 },
            { x = 120, y = 288 },
            { x = 96, y = 288 },
            { x = 96, y = 216 },
            { x = 120, y = 192 },
            { x = 96, y = 192 },
            { x = 96, y = 120 },
            { x = 120, y = 96 },
            { x = 96, y = 96 },
            { x = 96, y = 0 },
            { x = 120, y = -24 },
            { x = 984, y = -24 },
            { x = 1008, y = 0 },
            { x = 1008, y = 96 },
            { x = 984, y = 96 },
            { x = 1008, y = 120 },
            { x = 1008, y = 192 },
            { x = 984, y = 192 },
            { x = 1008, y = 216 },
            { x = 1008, y = 288 },
            { x = 984, y = 288 },
            { x = 1032, y = 336 },
            { x = 1032, y = 0 },
            { x = 1056, y = -24 },
            { x = 1080, y = -24 },
            { x = 1104, y = 0 },
            { x = 1104, y = 360 },
            { x = 1056, y = 408 },
            { x = 1080, y = 408 },
            { x = 1104, y = 432 },
            { x = 1104, y = 456 },
            { x = 1080, y = 456 },
            { x = 1080, y = 480 },
            { x = 1104, y = 504 },
            { x = 1104, y = 528 },
            { x = 1080, y = 528 },
            { x = 1080, y = 552 },
            { x = 1104, y = 576 },
            { x = 1104, y = 600 },
            { x = 1080, y = 600 },
            { x = 1080, y = 624 },
            { x = 1104, y = 648 },
            { x = 1104, y = 672 },
            { x = 1080, y = 696 },
            { x = 24, y = 696 },
            { x = 0, y = 672 },
            { x = 0, y = 648 },
            { x = 24, y = 624 },
            { x = 24, y = 600 },
            { x = 0, y = 600 },
            { x = 0, y = 576 },
            { x = 24, y = 552 },
            { x = 24, y = 528 },
            { x = 0, y = 528 },
            { x = 0, y = 504 },
            { x = 24, y = 480 },
            { x = 24, y = 456 },
            { x = 0, y = 456 },
            { x = 0, y = 432 },
            { x = 24, y = 408 },
            { x = 48, y = 408 },
            { x = 0, y = 360 },
            { x = 0, y = 0 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polyline",
          x = 408,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -192, y = 192 },
            { x = -216, y = 192 },
            { x = 0, y = -24 },
            { x = 216, y = 192 },
            { x = 192, y = 192 },
            { x = 0, y = 0 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polyline",
          x = 648,
          y = 96,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -144, y = 144 },
            { x = -168, y = 120 },
            { x = -144, y = 120 },
            { x = 0, y = -24 },
            { x = 312, y = 288 },
            { x = 288, y = 288 },
            { x = 0, y = 0 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polyline",
          x = 408,
          y = 312,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 24, y = -24 },
            { x = -24, y = -24 },
            { x = 0, y = 0 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polyline",
          x = 768,
          y = 360,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -24, y = -24 },
            { x = 24, y = -24 },
            { x = 0, y = 0 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polyline",
          x = 648,
          y = 216,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -24, y = -24 },
            { x = 24, y = -24 },
            { x = 0, y = 0 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polyline",
          x = 144,
          y = 432,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -24, y = 24 },
            { x = 552, y = 24 },
            { x = 528, y = 0 },
            { x = 0, y = 0 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polyline",
          x = 744,
          y = 432,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -24, y = 24 },
            { x = 288, y = 24 },
            { x = 264, y = 0 },
            { x = 0, y = 0 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "LightCollider",
      visible = false,
      opacity = 1,
      properties = {
        ["shadow"] = "true"
      },
      objects = {
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 0,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 768 },
            { x = 1152, y = 768 },
            { x = 1152, y = 0 },
            { x = 0, y = 0 },
            { x = 24, y = 48 },
            { x = 48, y = 24 },
            { x = 72, y = 24 },
            { x = 96, y = 48 },
            { x = 96, y = 384 },
            { x = 144, y = 336 },
            { x = 120, y = 336 },
            { x = 120, y = 264 },
            { x = 144, y = 240 },
            { x = 120, y = 240 },
            { x = 120, y = 168 },
            { x = 144, y = 144 },
            { x = 120, y = 144 },
            { x = 120, y = 48 },
            { x = 144, y = 24 },
            { x = 1008, y = 24 },
            { x = 1032, y = 48 },
            { x = 1032, y = 144 },
            { x = 1008, y = 144 },
            { x = 1032, y = 168 },
            { x = 1032, y = 240 },
            { x = 1008, y = 240 },
            { x = 1032, y = 264 },
            { x = 1032, y = 336 },
            { x = 1008, y = 336 },
            { x = 1056, y = 384 },
            { x = 1056, y = 48 },
            { x = 1080, y = 24 },
            { x = 1104, y = 24 },
            { x = 1128, y = 48 },
            { x = 1128, y = 408 },
            { x = 1080, y = 456 },
            { x = 1104, y = 456 },
            { x = 1128, y = 480 },
            { x = 1128, y = 504 },
            { x = 1104, y = 504 },
            { x = 1104, y = 528 },
            { x = 1128, y = 552 },
            { x = 1128, y = 576 },
            { x = 1104, y = 576 },
            { x = 1104, y = 600 },
            { x = 1128, y = 624 },
            { x = 1128, y = 648 },
            { x = 1104, y = 648 },
            { x = 1104, y = 672 },
            { x = 1128, y = 696 },
            { x = 1128, y = 720 },
            { x = 1104, y = 744 },
            { x = 48, y = 744 },
            { x = 24, y = 720 },
            { x = 24, y = 696 },
            { x = 48, y = 672 },
            { x = 48, y = 648 },
            { x = 24, y = 648 },
            { x = 24, y = 624 },
            { x = 48, y = 600 },
            { x = 48, y = 576 },
            { x = 24, y = 576 },
            { x = 24, y = 552 },
            { x = 48, y = 528 },
            { x = 48, y = 504 },
            { x = 24, y = 504 },
            { x = 24, y = 480 },
            { x = 48, y = 456 },
            { x = 72, y = 456 },
            { x = 24, y = 408 },
            { x = 24, y = 48 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 120,
          y = 456,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 24, y = -24 },
            { x = 552, y = -24 },
            { x = 576, y = 0 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 720,
          y = 456,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 24, y = -24 },
            { x = 288, y = -24 },
            { x = 312, y = 0 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 192,
          y = 384,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 216, y = -216 },
            { x = 432, y = 0 },
            { x = 408, y = 0 },
            { x = 216, y = -192 },
            { x = 24, y = 0 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 384,
          y = 288,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 24, y = 24 },
            { x = 48, y = 0 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 624,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 24, y = 24 },
            { x = 48, y = 0 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 480,
          y = 216,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 24, y = 24 },
            { x = 168, y = -120 },
            { x = 456, y = 168 },
            { x = 480, y = 168 },
            { x = 168, y = -144 },
            { x = 24, y = 0 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 744,
          y = 336,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 48, y = 0 },
            { x = 24, y = 24 }
          },
          properties = {}
        }
      }
    }
  }
}
