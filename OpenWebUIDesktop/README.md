# OpenWebUI macOS Desktop Wrapper

Нативное macOS приложение-обертка для [OpenWebUI](https://github.com/open-webui/open-webui), написанное на Swift и SwiftUI. Позволяет удобно использовать OpenWebUI как отдельное приложение с быстрым переключением между локальным и внешним адресами сервера.

---

<details>
<summary><b>English Version (Click to expand)</b></summary>

## Overview
A native macOS wrapper for [OpenWebUI](https://github.com/open-webui/open-webui), built with Swift and SwiftUI. It allows you to use OpenWebUI as a standalone desktop application with easy switching between local and external server addresses.

## Key Features
*   **Configurable URLs**: Easily set your custom Local and External server addresses in the app settings. No code changes required.
*   **Startup Preference**: Choose which mode (Local or External) should be active by default when the app starts.
*   **Two Connection Modes**: Instant switching between Local URL (e.g., for home use) and External URL (e.g., for remote access via domain).
*   **Zoom Controls**: Adjust web content scale (zoom in/out/reset) directly from the toolbar.
*   **Centered Toolbar**: Modern, balanced layout with all primary navigation and controls grouped in the center.
*   **Native Navigation**: Simple toolbar with Back, Forward, Refresh, and Home buttons.
*   **Smart Termination**: The app fully quits when the main window is closed.
*   **Persistence**: Saves your URLs, zoom level, and startup preference across sessions.

## How to Use
1.  Launch the app.
2.  Click the gear icon (**⚙️**) on the right side of the toolbar.
3.  Enter your server addresses:
    *   **Local URL**: Your server's local address (e.g., `http://192.168.x.x:2876`)
    *   **External URL**: Your server's external domain (e.g., `https://your-domain.me:2876`)
4.  Choose your **Startup Preference** (which URL to load on launch).
5.  Click **Done**. The app will reload and connect.
6.  Use the centered segmented picker to toggle between modes.

## How to Build
1.  Open `OpenWebUIDesktop.xcodeproj` in Xcode.
2.  Select "My Mac" as the target.
3.  Press `Cmd + R` to build and run.

## Tech Stack
*   Swift 5.0+ / SwiftUI
*   WebKit (WKWebView)
*   AppKit integration

</details>

---

## Основные возможности

*   **Настраиваемые адреса**: Легко указывайте свои собственные локальный и внешний адреса сервера прямо в настройках приложения.
*   **Предпочтение при запуске**: Выберите, какой режим (Local или External) должен активироваться автоматически при открытии приложения.
*   **Два режима работы**: Мгновенное переключение между локальным адресом (для дома) и внешним (для доступа через интернет).
*   **Управление масштабом**: Кнопки изменения масштаба (Zoom) в панели инструментов для удобного чтения.
*   **Центрированный интерфейс**: Все важные кнопки (навигация, переключатель режимов, зум) собраны в центре панели для удобства.
*   **Нативная навигация**: Кнопки «Назад», «Вперед», «Обновить» и «Домой».
*   **Умное закрытие**: Приложение полностью завершает работу при закрытии окна.
*   **Сохранение состояния**: Ваши адреса, уровень масштаба и настройки запуска сохраняются автоматически.

## Как использовать

1.  Запустите приложение.
2.  Нажмите на иконку шестеренки (**⚙️**) справа в панели инструментов.
3.  Введите адреса серверов:
    *   **Local URL**: Ваш локальный адрес (например, `http://192.168.x.x:2876`)
    *   **External URL**: Ваш внешний адрес (например, `https://your-domain.me:2876`)
4.  Выберите **Startup Preference** (какой режим грузить при запуске).
5.  Нажмите **Done**. Приложение перезагрузится с новыми данными.
6.  Используйте переключатель в центре для выбора режима.

## Как собрать проект

1.  Откройте файл `OpenWebUIDesktop.xcodeproj` в Xcode.
2.  Выберите цель (Target) "My Mac".
3.  Нажмите `Cmd + R` для сборки и запуска.

## Технологический стек

*   Swift 5.0+ / SwiftUI
*   WebKit (WKWebView)
*   AppKit (NSViewRepresentable)

---
*Приложение разработано для максимально удобного доступа к персональному серверу OpenWebUI.*
