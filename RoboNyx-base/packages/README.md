# Custom Packages

This directory holds any custom packages you would like to use in your system.

The `orca-slicer` package is a template for you to use as a reference point.

To add a new custom package, follow these steps:

1. Create a new directory for your package in this folder.
1. Create a `package.nix` file inside that directory.
1. Create your package as you would any other package.
1. You can now reference that package anywhere in your configs by referencing `self.packages.{your-package-name}`.
