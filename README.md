### IGON - Iguana Object Notation

The default markup language for rendering graphical user interfaces in Iguana OS, making an Iguana Application
compatible with `Android`, `iOS`, `Windows Phone`, `Windows`, `Linux`, `Mac OS X` and `BSD`.

#### Example

```javascript
{Igon version "0.1" |}
{Window
  windows:width 600
  windows:height 500
  iguana:windows 500
  iguana:height 400
  width 400
  height 300 }
  {View
    layout "match_parent" }
    {Button
      layout "match_parent"
      windows:text "Click me! (Windows)"
      iguana:text "Click me! (Iguana)"
      text "Click me! (Other OS)"
      onclick "alert('Hello World')" |}
  {|View}
{|Window}
```
