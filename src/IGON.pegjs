/**
 * Iguana Object Notation
 * Copyright 2015 Marcelo Camargo <marcelocamargo@linuxmail.org>
 */
Start
  = Tag*

/* Tag matching */

Tag "tag"
  = SelfClosedTag
  / ParentTag

SelfClosedTag "self-closed tag"
  = _ "{" _ tag:Ident _ "|}" _ {
    return {
      type: "SelfClosedTag",
      tag: tag
    }
  }

ParentTag
  = _ "{" _ tagStart:Ident _ "}" _ tags:Tag* _ "{|" tagEnd:Ident _ "}" {
    if (tagStart !== tagEnd) {
      throw new Error("Unmatched tag {" + tagStart + "}");
    }
    return {
      type: "ParentTag",
      tag: tagStart,
      subtags: tags
    }
  }

/* Identifier */
Ident "identifier"
  = name:IdentName {
    return name;
  }

IdentName
  = x:IdentStart xs:IdentRest* {
    return [x].concat(xs).join("");
  }

IdentStart
  = [a-z_]i

IdentRest
  = [a-z0-9_]i

/* Skipped */
_
  = (WhiteSpace / NewLine)*

WhiteSpace "whitespace"
  = "\t"
  / "\v"
  / "\f"
  / " "

NewLine "newline"
  = "\n"
  / "\r\n"
  / "\r"
  / "\u2028"
  / "\u2029"
