# 《勇者传说》Godot2D学习项目

## Ⅰ、玩法简介
本项目为横版2D动作冒险游戏Demo，玩家可操控主角在不同场景中移动、跳跃、攻击、滑铲、与场景交互，体验基础的动作与关卡探索。

## Ⅱ、项目结构
~~~bash
├── assets/           # 素材资源（角色、环境、UI等）
├── scenes/           # 游戏场景（player、enemy、boar、mine_gate等）
├── scripts/          # 主要脚本（player.gd、enemy.gd、boar.gd、world.gd等）
├── ui/               # UI相关资源（status_panel等）
├── worlds/           # 世界/关卡场景（cave.tscn、forest.tscn等）
├── globals/          # 全局脚本与配置（game.gd等）
├── classes/          # 通用类与交互（teleporter.gd、entry_point.gd等）
├── addons/           # Godot插件
├── project.godot     # Godot项目主配置文件
└── README.md         # 项目说明文档
~~~

## Ⅲ、操作说明
- **移动**：A/D 或 ←/→
- **跳跃**：空格 或 W
- **攻击**：J
- **滑铲**：K
- **交互**：E

## Ⅳ、调试方法
1. 安装 [Godot 4.4.1](https://godotengine.org/zh-cn/) 或兼容版本。
2. 使用 Godot 打开本项目文件夹。
3. 进入主场景(worlds/forest.tscn)即可运行游戏。

## Ⅴ、素材来源
* 人物素材： https://brullov.itch.io/generic-char-asset
* 环境素材： https://anokolisa.itch.io/sidescroller-pixelart-sprites-asset-pack-forest-16x16
* 按键提示： https://greatdocbrown.itch.io/gamepad-ui
* 字体素材： https://www.bilibili.com/video/BV1sP411g7PZ
* 音效素材： https://www.kenney.nl/assets/impact-sounds https://leohpaz.itch.io/minifantasy-dungeon-sfx-pack
* 音乐素材： https://sonatina.itch.io/infinity-crystal

## Ⅵ、延伸阅读
1. [十分钟制作横版动作游戏｜Godot 4 教程《勇者传说》#0](https://www.bilibili.com/video/BV1SP411m7aj)
2. [timothyqiu/godot-2d-adventure-tutorial: Godot 4 横版动作游戏教程](https://github.com/timothyqiu/godot-2d-adventure-tutorial)
