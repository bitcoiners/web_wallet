angular.module("app").controller "UnlockWalletController", ($scope, $modal, $log, RpcService, Wallet) ->
  $scope.descriptionCollapsed = true


  # hide error messages until 'submit' event
  $scope.submitted = false
  # hide success message
  $scope.showMessage = false
    

  $scope.submit = ->
    $scope.showMessage = true
    Wallet.wallet_unlock($scope.spending_password).then ->
      window.location.href = "/"
      return
