angular.module '%module%.burndown'
.factory 'BurndownSettings',
($window, $rootScope, UserTrello, Resources) ->
  saveTeam = ->
    $window.localStorage.team = JSON.stringify $rootScope.user.team
    $window.localStorage.resources = JSON.stringify $rootScope.user.resources

  initTeam = (memberId) ->
    # console.log 'initTeam', memberId
    $rootScope.user.team =
      dev: [memberId]
      other: []
    $rootScope.user.resources = Resources.generate $rootScope.user.team.dev, $rootScope.user.sprintDays
    saveTeam()

  addDev = ->
    for day in $rootScope.user.resources
      day = day.push 1
    saveTeam()

  removeDev = (index) ->
    # console.log 'remove team index', index
    for day in $rootScope.user.resources
      day = day.splice index, 1
    saveTeam()

  getSettings = ->
    # console.log 'getSettings', $rootScope.user
    UserTrello.getUserSettings()
    if (not $rootScope.user.team) or (not $rootScope.user.resources)
      initTeam $rootScope.user.memberId
    $rootScope.user

  getSettings: getSettings
  saveTeam: saveTeam
  removeDev: removeDev
  addDev: addDev