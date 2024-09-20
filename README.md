<p align="center">
  <a href="https://github.com/swiftly-solution/swiftly">
    <img src="https://cdn.swiftlycs2.net/swiftly-logo.png" alt="SwiftlyLogo" width="80" height="80">
  </a>

  <h3 align="center">[Swiftly] MVP Sound</h3>

  <p align="center">
    A simple plugin for Swiftly that implements MVP sounds (from the workshop). Players can choose which MVP kit to play and adjust the volume of the sound.
    <br/>
  </p>
</p>

<p align="center">
  <img src="https://img.shields.io/github/downloads/m3ntorsky/mvp/total" alt="Downloads"> 
  <img src="https://img.shields.io/github/contributors/m3ntorsky/mvp?color=dark-green" alt="Contributors">
  <img src="https://img.shields.io/github/issues/m3ntorsky/mvp" alt="Issues">
  <img src="https://img.shields.io/github/license/m3ntorsky/mvp" alt="License">
</p>

---
### Requirements 🛠️

- [Cookies](https://github.com/swiftly-solution/cookies/releases)

### Installation 👀

1. Download the newest [release](https://github.com/m3ntorsky/mvp/releases).
2. Everything is drag & drop, so I think you can do it!

### Configuring the plugin 🧐

* After installing the plugin, you can add a music kits on section musickits in `addons/swiftly/configs/plugins/mvp.json`

```json
{
    "musickits": {
        "bungee.boks" : { // unique identifier
            "display": "Bungee : Boks", // Display name, which is shown in the menu and notifications
            "event": "boks", // Event for the sounds, check it here: https://swiftlycs2.net/docs/configuration/menu.html#sound-name
            "path": "sounds/boks.vsnd", // Path to the sound file
            "can_preview": true, // Can the player preview the sound before choosing? true/false
            "can_equip" : true // Can the player equip music kits? true/false
        }
    }
}
```

### MVP Commands 💬

* Base commands provided by this plugin:

|      Command     |               Description              |
|:----------------:|:--------------------------------------:|
|     !mvp    |        MVP control panel menu.        |


### Creating A Pull Request 😃

1. Fork the Project
2. Create your Feature Branch
3. Commit your Changes
4. Push to the Branch
5. Open a Pull Request

### Have ideas/Found bugs? 💡
Join [Swiftly Discord Server](https://swiftlycs2.net/discord) and send a message in the topic from `📕╎plugins-sharing` of this plugin!

---
