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
  = _ "{" _ tag:Ident _ args:Argument* _ "|}" _ {
    return {
      type: "SelfClosedTag",
      tag: tag,
      arguments: args ? args : []
    }
  }

ParentTag
  = _ "{" _ tagStart:Ident _ args:Argument* _ "}" _ tags:Tag* _ "{|" tagEnd:Ident _ "}" {
    if (tagStart !== tagEnd) {
      throw new Error("Unmatched tag {" + tagStart + "}");
    }
    return {
      type: "ParentTag",
      tag: tagStart,
      subtags: tags,
      arguments: args ? args : []
    };
  }

/* Argument matching */
Argument "argument"
  = _ begin:Ident _ end:ArgumentIdentEnd? _ expr:IGONExpr _ {
    return {
      type: "Argument",
      key: end ? [begin, end] : begin,
      value: expr
    };
  }

ArgumentIdentEnd
  = ":" _ name:Ident {
    return name;
  }

/* Identifier */
Ident "identifier"
  = !Keyword name:IdentName {
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

/* IGON Expression */
IGONExpr "expression"
  = Bool
  / Integer
  / Double
  / String
  / Nil { return null; }

Bool
  = True { return true; }
  / False { return false; }

Integer
  = n:[0-9]+ !"." {
    return parseInt(n.join(""));
  }

Double
  = x:[0-9]+ "." xs:[0-9]+ {
    return parseFloat(x.concat(xs).join(""));
  }

String
  = '"' str:ValidStringChar* '"' {
    return str.join("");
  }

ValidStringChar
  = !'"' c:. {
    return c;
  }

/* Keywords */
Keyword
  = True
  / False

True
  = "True"

False
  = "False"

Nil
  = "Nil"

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
