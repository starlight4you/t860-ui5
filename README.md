# t860-ui5 — Galaxy Tab S6 (SM-T860) One UI 5 刷机包

> **本项目已结束支持。** 请前往 [t860-ui6](https://github.com/starlight4you/t860-ui6) 了解更新的 **One UI 6** 刷机包。

为 **Samsung Galaxy Tab S6 Wi‑Fi (SM-T860 / gts6lwifi)** 移植的 One UI 5 (Android 13) GSI 刷机包，包含已修复的 system 镜像、禁用 AVB 校验的 vbmeta、TWRP Recovery，以及可选的 Magisk 模块。

## 功能兼容性

除表格中标注不可用或未测试的项目外，其余功能均可正常使用。

| 功能 | 状态 |
|------|------|
| **Wi‑Fi 无线网络** | ✅ 正常 |
| **触摸屏 / 显示** | ✅ 正常 |
| **S Pen 触控笔** | ✅ 正常 |
| **前置 / 后置摄像头** | ❓ 未测试 |
| **麦克风录音** | ✅ 正常 |
| **USB 充电与数据传输** | ✅ 正常 |
| **音量键 / 电源键** | ✅ 正常 |
| **屏幕旋转 / 自动亮度** | ✅ 正常 |
| **加速度计 / 陀螺仪等传感器** | ✅ 正常 |
| **One UI 5 界面与动画** | ✅ 正常 |
| **Android 13 系统功能** | ✅ 正常 |
| **应用安装与运行** | ✅ 正常 |
| **Google 服务 / Play 商店** | ✅ 正常 |
| **通知栏 / 多任务 / 分屏** | ✅ 正常 |
| **设置** | ✅ 正常 |
| **Samsung 预装应用** | ✅ 正常 |
| **TWRP Recovery 刷机** | ✅ 正常 |
| **系统更新检查** | ❌ 不可用 |
| **DeX 桌面模式** | ❌ 不可用 |
| **指纹识别** | ❌ 不可用 |
| **蓝牙** | ❌ 不可用 |
| **内置扬声器** | ⚠️ 仅一侧有声音 |

## 适用机型

- **Samsung Galaxy Tab S6 Lite Wi‑Fi**
- 型号：**SM-T860**
- 代号：**gts6lwifi**

其他变体（如 LTE 版 SM-P610 等）未经测试，请勿刷入。

## 刷机前准备

### 硬件

- USB 数据线（建议原装或质量好的线）
- 电脑（macOS / Linux；Windows 请自行安装 Heimdall）

### 软件

- 已解锁 Bootloader（开发者选项 → OEM 解锁）
- 已安装 [Samsung USB 驱动](https://developer.samsung.com/android-usb-driver)（Windows）
- macOS 用户可直接使用本仓库 `tools/macos/heimdall`

### 备份

刷机将**清除全部数据**，请提前备份重要文件。建议同时备份当前原厂固件（可使用 `heimdall download-pit` 等方式）。

## 文件说明

```
t860-ui5/
├── images/
│   ├── OneUI-5.0-TabS6-Fixed-sparse.img   # 主系统镜像（One UI 5 GSI，已针对 T860 修复）
│   └── vbmeta_disabled.img                # 禁用 AVB 校验
├── recovery/
│   └── twrp-3.7.0_9-0-gts6lwifi.img       # TWRP Recovery
├── tools/
│   └── macos/heimdall                     # macOS 刷机工具
├── modules/                               # 可选 Magisk 模块（在 One UI 4 上叠加 UI 更新）
│   ├── oneui5-lowrisk-existing.zip
│   └── oneui5-ui-experimental.zip
├── optional/adb-apks/                     # 可选 ADB 安装包
└── scripts/
    ├── flash-macos.sh
    └── flash-linux.sh
```

## 下载

1. **克隆本仓库**（含脚本与文档）：
   ```bash
   git clone https://github.com/starlight4you/t860-ui5.git
   cd t860-ui5
   ```

2. **从 [Releases](https://github.com/starlight4you/t860-ui5/releases) 下载刷机资源**，解压到对应目录：
   - `OneUI-5.0-TabS6-Fixed-sparse.img.gz.part-*` → `images/`（合并见下方）
   - `twrp-3.7.0_9-0-gts6lwifi.img` → `recovery/`
   - `oneui5-*.zip` → `modules/`（可选）
   - `adb-apks.zip` → `optional/`（可选）

3. **合并并解压系统镜像**（分卷下载后）：
   ```bash
   chmod +x scripts/merge-image.sh
   ./scripts/merge-image.sh --extract
   ```

## 刷机教程

### 方法一：Heimdall 线刷（推荐）

1. **进入 Download 模式**
   - 平板关机
   - 按住 **音量上 + 音量下**，同时插入 USB 线连接电脑
   - 出现警告画面后按 **音量上** 确认进入 Download 模式

2. **解压系统镜像**（若下载的是 `.img.gz`）
   ```bash
   gzip -dk images/OneUI-5.0-TabS6-Fixed-sparse.img.gz
   ```

3. **执行刷机脚本**

   **macOS：**
   ```bash
   chmod +x scripts/flash-macos.sh tools/macos/heimdall
   ./scripts/flash-macos.sh
   ```

   **Linux：**
   ```bash
   # 先安装 heimdall：sudo apt install heimdall-flash   # Debian/Ubuntu
   chmod +x scripts/flash-linux.sh
   ./scripts/flash-linux.sh
   ```

4. **首次启动**
   - 刷机完成后设备会自动重启
   - 首次开机约需 **5–15 分钟**，请耐心等待
   - 进入系统后完成初始设置

### 方法二：TWRP 卡刷

1. 进入 Download 模式，刷入 TWRP：
   ```bash
   heimdall flash --RECOVERY recovery/twrp-3.7.0_9-0-gts6lwifi.img
   ```

2. 重启进入 Recovery（Download 模式下按 **音量上 + 电源** 组合，或 `heimdall reboot` 后立刻按住对应按键进入 TWRP）

3. 在 TWRP 中依次操作：
   - **Wipe** → Advanced Wipe → 勾选 Data、Cache、Dalvik
   - **Install** → 选择 `vbmeta_disabled.img`，刷入到 **vbmeta** 分区
   - **Install** → 选择 `OneUI-5.0-TabS6-Fixed-sparse.img`，刷入到 **system** 分区
   - **Reboot** → System

### 可选：Magisk 模块（One UI 4 叠加方案）

若你**未刷 GSI**、仍停留在 One UI 4 且已 Root (Magisk)，可尝试安装 `modules/` 下的模块以获得部分 One UI 5 应用更新：

- `oneui5-lowrisk-existing.zip` — 保守更新，风险较低
- `oneui5-ui-experimental.zip` — 包含启动器、键盘等，风险较高

> 模块仅替换已存在于原厂系统中的同名应用，不包含 framework-res、SystemUI 等核心组件。

## 手动刷机命令

```bash
# 进入 Download 模式后执行
heimdall flash --VBMETA images/vbmeta_disabled.img --no-reboot
heimdall flash --SYSTEM images/OneUI-5.0-TabS6-Fixed-sparse.img --no-reboot
heimdall reboot
```

## 恢复原厂

1. 下载 SM-T860 官方固件（Odin 格式）
2. 使用 Odin（Windows）或 Heimdall 刷回原厂 `system`、`vbmeta`、`boot` 等分区
3. 或在 TWRP 中恢复之前备份的分区

## 免责声明

- 刷机有风险，可能导致设备变砖或失去保修
- 本包为社区移植项目，按「原样」提供，作者不对任何损失负责
- 本项目已停止维护，请使用 [One UI 6 新版刷机包](https://github.com/starlight4you/t860-ui6)

## 致谢

- 基于 [NipponGSI One UI 5.0](https://github.com/nippongsi) 移植
- TWRP by [Team Win Recovery Project](https://twrp.me/)
