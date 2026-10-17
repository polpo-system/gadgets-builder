# gadgets-builder

Builder for the gadgets of [polpo](https://github.com/polpo-system/polpo), on x86: a front end of
the compiler. It finds the order in which a list of modules must be compiled (or freed) from their
imports, compiles them, and marks the errors in the source text with small gadgets.

```
portia.Install gadgets-builder
```

## Using

    Builder.Compile *              compile the marked text
    Builder.Compile \sx names ~    compile the files in the order of their imports
    Builder.Free names ~           free modules in the right order
    Builder.MarkErrors ^           error markers in the marked text (the error list selected)
    Builder.NextError              to the next error marker after the caret
    Builder.ClearErrors *          remove the markers

`tools/Builder.Tool` (from Linux Oberon) has these commands.

## What is here

    src/OLR.Builder.Mod      the builder
    tools/Builder.Tool
    test/BuilderTest.Mod

It uses the modules of the x86 compiler (OPS, OPM, OPT), so the package installs on x86 only. The source comes from ETH Linux Oberon (OLR, 2017-06-18), converted from an Oberon text to
plain text; the first commit has it unchanged.

## Tests

    BuilderTest.Run      2 checks: the module loaded, an error marker made; it needs the
                         desktop's display (on x86)

The license is GPL-3 (`LICENSE`); the code comes from ETH Oberon, whose license (`LICENSE.ETH`)
asks to keep its copyright notice and conditions, which `LICENSE.ETH` does.
