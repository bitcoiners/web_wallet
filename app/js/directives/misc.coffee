angular.module("app.directives").directive "focusMe", ($timeout) ->
  scope:
    trigger: "@focusMe"
  link: (scope, element) ->
    scope.$watch "trigger", ->
      $timeout ->
        element[0].focus()

angular.module("app.directives").directive "pwCheck", ->
  require: "ngModel"
  link: (scope, elem, attrs, ctrl) ->
    firstPassword = "#" + attrs.pwCheck
    elem.add(firstPassword).on "keyup", ->
      scope.$apply ->
        v = elem.val() is $(firstPassword).val()
        ctrl.$setValidity "pwmatch", v


angular.module("app.directives").directive "uncapitalize", ->
  require: "ngModel"
  link: (scope, element, attrs, modelCtrl) ->
    uncapitalize = (inputValue) ->
      uncapitalized = inputValue.toLowerCase()
      if uncapitalized isnt inputValue
        modelCtrl.$setViewValue uncapitalized
        modelCtrl.$render()
      uncapitalized

    modelCtrl.$parsers.push uncapitalize
    uncapitalize scope[attrs.ngModel] # uncapitalize initial value
    return

angular.module("app.directives").directive "shakeThat", [
  "$animate"
  ($animate) ->
    return (
      require: "^form"
      scope:
        submit: "&"
        submitted: "="

      link: (scope, element, attrs, form) ->
        
        # listen on submit event
        element.on "submit", ->
          console.log('submitting....')
          
          # tell angular to update scope
          scope.$apply ->
            
            # everything ok -> call submit fn from controller
            #return scope.submit()  if form.$valid
            
            # show error messages on submit
            scope.submitted = true
            
            # shake that form
            $animate.addClass element, "shake", ->
              console.log('adding class')
              #$animate.removeClass element, "shake"
              return

            return

          return

        return
    )
]