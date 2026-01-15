# AGENTS.md

This file provides guidance to agents when working with code in this repository.

## 项目特定命令
- **初始化项目**: `pwsh ./Start.ps1` (安装依赖并设置环境)
- **运行示例**: `pwsh ./example.ps1` (演示PowerShell最佳实践)
- **代码分析**: `Invoke-ScriptAnalyzer -Path .` (使用PSScriptAnalyzer检查代码)

## 开发环境配置
- **容器化开发**: 使用.devcontainer/中的Docker配置
- **PowerShell版本**: 要求PowerShell 7.0或更高版本
- **默认终端**: pwsh (PowerShell)
- **VS Code扩展**: ms-vscode.PowerShell (自动安装)

## 项目结构特点
- **输出目录**: 自动创建output/, logs/, temp/目录
- **模块管理**: 使用PowerShell Gallery和Install-Module
- **代码格式化**: 保存时自动格式化(OTBS预设)

## 关键发现
- **启动脚本**: Start.ps1自动安装PSScriptAnalyzer和Pester模块
- **代码分析**: .vscode/PSScriptAnalyzerSettings.psd1配置规则
- **调试支持**: launch.json预配置了PowerShell调试配置
- **环境变量**: PROJECT_ROOT由Start.ps1自动设置

## 非标准实践
- 使用PSScriptAnalyzer进行静态代码分析(而非传统编译检查)
- Write-Host在脚本中被允许(通过PSScriptAnalyzerSettings.psd1配置)
- 所有脚本使用[CmdletBinding()]以支持高级参数和通用参数
