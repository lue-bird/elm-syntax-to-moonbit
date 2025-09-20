// turn elm.mbt into an escaped elm string
// and inserts it at ElmSyntaxToMoonbit.defaultDeclarations
import * as fs from "node:fs"
import * as path from "node:path"

function indexAfterFirst(needle, lookFromIndex, full) {
    return full.indexOf(needle, lookFromIndex) + needle.length
}

const defaultDeclarationsMoonbitFile =
    fs.readFileSync(
        path.join(import.meta.dirname, "elm.mbt"),
        { encoding: "utf-8" }
    )
const elmSyntaxToMoonbitElmPath = path.join(import.meta.dirname, "ElmSyntaxToMoonbit.elm")
const elmSyntaxToMoonbitElmFile =
    fs.readFileSync(elmSyntaxToMoonbitElmPath, { encoding: "utf-8" })

const elmString =
    "\"\"\"\n"
    + defaultDeclarationsMoonbitFile
        .slice(
            defaultDeclarationsMoonbitFile.indexOf("//"),
            defaultDeclarationsMoonbitFile.length
        )
        .replaceAll("\\", "\\\\")
        .trim()
    + "\n\"\"\""
const defaultDeclarationsDeclarationStartIndex =
    elmSyntaxToMoonbitElmFile.indexOf(`"""\n//`)
const defaultDeclarationsDeclarationToReplace =
    elmSyntaxToMoonbitElmFile.slice(
        defaultDeclarationsDeclarationStartIndex,
        indexAfterFirst(`\n"""`, defaultDeclarationsDeclarationStartIndex, elmSyntaxToMoonbitElmFile)
    )
const elmSyntaxToMoonbitElmFileWithUpdatedDefaultDeclarations =
    elmSyntaxToMoonbitElmFile.replace(defaultDeclarationsDeclarationToReplace, elmString)
fs.writeFileSync(
    elmSyntaxToMoonbitElmPath,
    elmSyntaxToMoonbitElmFileWithUpdatedDefaultDeclarations,
    { encoding: "utf-8" }
)
