class SetColorPrimary extends ContentTools.Tools.Bold

    ContentTools.ToolShelf.stow(@, 'set-color-primary')

    @label = 'Set Color Primary'
    @icon = 'set-color-primary'
    @className = 'text-primary'

    @canApply: (element, select) ->
      # Return true if the tool can be applied to the current
      # element/selection.
      return element.content != undefined

    @isApplied: (element, selection) ->
        # Return true if the tool is currently applied to the current
        # element/selection.
        if not @canApply(element)
            return false

        # List items and table cells use child nodes to manage their content
        # which don't support classes, so we need to check the parent.
        if element.constructor.name in ['ListItemText', 'TableCellText']
            element = element.parent()

        return element.hasCSSClass(@className)

    @apply: (element, selection, callback) ->
        # Apply the tool to the current element

        # List items and table cells use child nodes to manage their content
        # which don't support classes, so we need to use the parent.
        if element.constructor.name in ['ListItemText', 'TableCellText']
            element = element.parent()

        # Remove any existing text alignment classes applied
        for className in ['text-center', 'text-left', 'text-right']
            if element.hasCSSClass(className)
                element.removeCSSClass(className)

                # If we're removing the class associated with the tool then we
                # can return early (this allows the tool to be toggled on/off).
                if className == @className
                    return callback(true)

        # Add the alignment class to the element
        element.addCSSClass(@className)

        callback(true)

class SetColorSuccess extends SetColorPrimary
  ContentTools.ToolShelf.stow(@, 'set-color-success')

  @label = 'Set Color Success'
  @icon = 'set-color-success'
  @className = 'text-success'

class SetColorDanger extends SetColorPrimary
  ContentTools.ToolShelf.stow(@, 'set-color-danger')

  @label = 'Set Color Danger'
  @icon = 'set-color-danger'
  @className = 'text-danger'

class SetColorWarning extends SetColorPrimary
  ContentTools.ToolShelf.stow(@, 'set-color-warning')

  @label = 'Set Color Warning'
  @icon = 'set-color-warning'
  @className = 'text-warning'


ContentTools.DEFAULT_TOOLS[0].push('set-color-primary')
ContentTools.DEFAULT_TOOLS[0].push('set-color-success')
ContentTools.DEFAULT_TOOLS[0].push('set-color-warning')
ContentTools.DEFAULT_TOOLS[0].push('set-color-danger')
