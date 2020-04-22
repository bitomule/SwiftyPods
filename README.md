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

Reading and editing the podfile becomes impossible when your project based on CocoaPods grows. You start grouping using variables and comments but it's still a long file where the safety is the error you get when you run pod install. 

SwiftyPods enables two big features:
* **Safety**: Swift will type check your file before you finish editing it.
* **Modularization of your podfile**: You can split your podfile in multiple podfile.swift files. You choose: feature pods, module pods, team pods... Once you generate your podfile they will all get merged into a single, classic podfile.

### This is what your podfile.swift will look like

```swift
let podfile = Podfile(
    targets: [
        .target(
            name: "Target",
            project: "Project",
            dependencies: [
                .dependency(name: "Dependency1"),
                .dependency(name: "Dependency2",
                            version: "1.2.3"),
                .dependency(name: "Dependency3",
                            .git(url: "repo"),
                            .branch(name: "master"))
            ],
            childTargets: [
                .target(name: "ChildTarget", project: "Project2")
            ]
        )
    ]
)
```

## Installing

### Using [Homebrew](http://brew.sh/)

```sh
$ brew install bitomule/homebrew-tap/swiftypods
```

### Using [Mint](https://github.com/yonaskolb/mint)

```sh
$ mint install bitomule/swiftypods
```
### Compiling from source

```sh
$ git clone https://github.com/bitomule/SwiftyPods.git
$ cd SwiftyPods
$ make install
```

## Usage
### Create your first empty podfile

You can create an empty podfile.swift using the create command:

```sh
$ swiftypods create
```

It takes an optional path parameter that you can use to create your podfile at an specific location:

```sh
$ swiftypods create --path "path/to/folder"
```

Once the file is created you can jump directly to editing.

### Editing

You can open your podfile.swift anytime and edit it, but if you want to use the power of the Swift compiler and autocomplete use:

```sh
$ swiftypods edit
```

This command will:
1) Find all your podfile.swift files inside the folder
2) Create a temporal Xcode project inside tmp folder
3) Open that project for you

Once the project is opened you can edit your files content.

When you have finished editing just close the Xcode project, go back to terminal and press any key. This will copy your templates back to original locations and delete temporal folder. Keep in mind that SwiftyPods has to copy edited files back to original locations. If you don't complete the terminal process, your podfiles won't be updated.

### Generating podfile

In order to generate your podfile just run:

```sh
$ swiftypods generate
```

By default it will use an almost empty podfile template but you can use your own template using:

```sh
$ swiftypods generate --template "templateLocation"
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
