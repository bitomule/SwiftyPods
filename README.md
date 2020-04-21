![Swift](https://github.com/bitomule/SwiftyPods/workflows/Swift/badge.svg)
<p align="left">
    <img src="https://img.shields.io/badge/Swift-5.2-orange.svg" />
    <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/swiftpm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
    </a>
     <img src="https://img.shields.io/badge/platforms-mac+linux-brightgreen.svg?style=flat" alt="Mac + Linux" />
    <a href="https://twitter.com/bitomule">
        <img src="https://img.shields.io/badge/twitter-@bitomule-blue.svg?style=flat" alt="Twitter: @bitomule" />
    </a>
</p>

# SwiftyPods

SwiftyPods is a command-line tool that allows you to generate your CocoaPods podfile using Swift. It uses [SwiftyPodsDSL](https://github.com/bitomule/SwiftyPodsDSL) as syntax.

## Motivation

When your project based on CocoaPods grows reading and editing the podfile becomes imposible. You start grouping using variables and comments but it's still a long file where the safety is the error you get when you run pod install. 

SwiftyPods enables two big features:
* Safety: Swift will type check your file before you finish editing it.
* Modularization of your podfile: You can split your podfile in multiple podfile.swift files. You choose: feature pods, module pods, team pods... Once you generate your podfile they will all get merged into a single, clasic podfile.

## Installing

### Using homebrew
### Using Mint
### Compiling from source


## Usage
### Create your first empty podfile

### Editing

You can always open your podfile.swift and edit it but declaring a podfile in Swift also means:
* Safety
* Autocomplete

#### Edit your podfile.swift files

In order to get this two magical features you have to use the edit command:
```
swiftypods edit
```

This command will:
1) Find all your podfile.swift files inside the folder
2) Create a temporal Xcode project inside tmp folder
3) Open that project for you

Once the project is opened you can edit your files content.

When you have finished editing just close the Xcode project, go back to terminal and press any key. This will copy your templates back to original locations and delete temporal folder.

### Generating podfile

In order to generate your podfile just run:

```
swiftypods generate
```

By default it will use an almost empty podfile template but you can use your own template using:

```
swiftypods generate --template "templateLocation"
```

The only thing your template needs to follow is adding {{pods}} where you want your dependencies to get generated. Base podfile template is:

```
platform :ios, '13.0'
inhibit_all_warnings!

{{pods}}
```

Use your own template to add features not supported by SwiftyPods like hooks or plugins.

## Contributions and support

Contributions are more than welcome.

Before you start using SwiftyPods, please take a few minutes to check the implementation so you can identify issues or missing features.

Keep in mind this is a very experimental project, expect breaking changes.

This project does not come with Github Issues enabled. If you find an issue, missing feature or missing documentation please [open a Pull Request](https://github.com/bitomule/SwiftyPods/pull/new). Your PR could just contain a draft of the changes you plan to do or a test that reproduces the issue so we can start the discussion there.
