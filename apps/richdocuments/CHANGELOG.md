# Changelog

## 8.3.13

### Fixed
- Adjust workflows docker images @elzody [#4165](https://github.com/nextcloud/richdocuments/pull/4165)
- Get user by display name @elzody [#4197](https://github.com/nextcloud/richdocuments/pull/4197)
- Properly throttle in error cases and add rate limit for public file creation @juliusknorr [#4203](https://github.com/nextcloud/richdocuments/pull/4203)
- Skip css variable if not set (prevent warning on COOL side) @timar [#4222](https://github.com/nextcloud/richdocuments/pull/4222)
- Limit open with Collabora action to pdf files @juliusknorr [#4232](https://github.com/nextcloud/richdocuments/pull/4232)
- Remove deprecated `title` parameter @elzody [#4270](https://github.com/nextcloud/richdocuments/pull/4270)
- Link share of federated share @max-nextcloud [#4282](https://github.com/nextcloud/richdocuments/pull/4282)
- Get storage from file instead of parent @elzody [#4304](https://github.com/nextcloud/richdocuments/pull/4304)
- Do not treat guest as share owner @elzody [#4308](https://github.com/nextcloud/richdocuments/pull/4308)
- Attempt to make cypress tests more stable with a unified wait for close @juliusknorr [#4294](https://github.com/nextcloud/richdocuments/pull/4294)

### Other
- `npm` audits [#4161](https://github.com/nextcloud/richdocuments/pull/4161), [#4190](https://github.com/nextcloud/richdocuments/pull/4190), [#4240](https://github.com/nextcloud/richdocuments/pull/4240), [#4266](https://github.com/nextcloud/richdocuments/pull/4266)
- Update Nextcloud dependencies [#4176](https://github.com/nextcloud/richdocuments/pull/4176), [#4237](https://github.com/nextcloud/richdocuments/pull/4237), [#4255](https://github.com/nextcloud/richdocuments/pull/4255), [#4296](https://github.com/nextcloud/richdocuments/pull/4296), [#4290](https://github.com/nextcloud/richdocuments/pull/4290)

## 8.3.12

### Fixed
* Display proper custom logo in collabora @elzody [#4106](https://github.com/nextcloud/richdocuments/pull/4106)
* Asset download checks @juliusknorr [#4135](https://github.com/nextcloud/richdocuments/pull/4135)
* Brute force protection for public file creation @juliusknorr [#4143](https://github.com/nextcloud/richdocuments/pull/4143)

### Other
* npm audit @nextcloud-command [#4092](https://github.com/nextcloud/richdocuments/pull/4092)
* Update nextcloud/ocp dependency @nextcloud-command [#4099](https://github.com/nextcloud/richdocuments/pull/4099)
* npm audit @nextcloud-command [#4118](https://github.com/nextcloud/richdocuments/pull/4118)

## 8.3.11

### Fixed

* Do not ask for guest name on read only pdfs @juliushaertl [#3953](https://github.com/nextcloud/richdocuments/pull/3953)
* Use shared default options for HTTP client requests @mejo- [#3993](https://github.com/nextcloud/richdocuments/pull/3993)
* Pressing `Enter` submits guest name input @elzody [#4008](https://github.com/nextcloud/richdocuments/pull/4008)
* Don't ask for guest name on view-only share @elzody [#4070](https://github.com/nextcloud/richdocuments/pull/4070)
* Properly render compare view @juliushaertl [#4076](https://github.com/nextcloud/richdocuments/pull/4076)
* Emit notification on mentions @juliushaertl [#4080](https://github.com/nextcloud/richdocuments/pull/4080)

### Other

* Update `@nextcloud` dependencies @skjnldsv [#4013](https://github.com/nextcloud/richdocuments/pull/4013)
* Bump `@nextcloud/axios` from 2.5.0 to 2.5.1 @dependabot [#4058](https://github.com/nextcloud/richdocuments/pull/4058)
* Bump `@nextcloud/cypress` from 1.0.0-beta.8 to 1.0.0-beta.9 @dependabot [#4059](https://github.com/nextcloud/richdocuments/pull/4059)
* Update `nextcloud/ocp` dependency @nextcloud-command [#4062](https://github.com/nextcloud/richdocuments/pull/4062)
* Bump `@nextcloud/dialogs` from 4.2.2 to 4.2.7 @dependabot [#3996](https://github.com/nextcloud/richdocuments/pull/3996)
* Bump `@nextcloud/router` from 2.2.0 to 2.2.1 @dependabot [#3997](https://github.com/nextcloud/richdocuments/pull/3997)
* Bump `eslint-plugin-cypress` from 2.15.1 to 2.15.2 @dependabot [#3998](https://github.com/nextcloud/richdocuments/pull/3998)
* Update `nextcloud/ocp` dependency @nextcloud-command [#4004](https://github.com/nextcloud/richdocuments/pull/4004)
* Bump `@cypress/webpack-preprocessor` from 6.0.0 to 6.0.2 @dependabot [#3978](https://github.com/nextcloud/richdocuments/pull/3978)
* Bump `@nextcloud/cypress` from 1.0.0-beta.6 to 1.0.0-beta.8 @dependabot [#3983](https://github.com/nextcloud/richdocuments/pull/3983)
* Bump `@nextcloud/vue` from 7.12.6 to 7.12.8 @dependabot [#3985](https://github.com/nextcloud/richdocuments/pull/3985)
* Bump `@nextcloud/browserslist-config` from 3.0.0 to 3.0.1 @dependabot [#3986](https://github.com/nextcloud/richdocuments/pull/3986)
* Bump `@nextcloud/webpack-vue-config` from 6.0.0 to 6.0.1 @dependabot [#3988](https://github.com/nextcloud/richdocuments/pull/3988)

## 8.3.10

### Fixed

* Block incompatible operations with remote tokens @juliushaertl [#3879](https://github.com/nextcloud/richdocuments/pull/3879)
* Show PDF even when download hidden on public share @elzody [#3888](https://github.com/nextcloud/richdocuments/pull/3888)
* Guest username not picked up the second time loading a share link @elzody [#3908](https://github.com/nextcloud/richdocuments/pull/3908)
* Properly send custom logo to collabora @elzody [#3930](https://github.com/nextcloud/richdocuments/pull/3930)
* Bring back federated editing in viewer iframe @juliushaertl [#3938](https://github.com/nextcloud/richdocuments/pull/3938)

### Other

* Switch to new API to set volatile user to prevent persisting it in any case @juliushaertl [#3861](https://github.com/nextcloud/richdocuments/pull/3861)
* Remove unnecessary files from release build @juliushaertl [#3881](https://github.com/nextcloud/richdocuments/pull/3881)


## 8.3.9

### Fixed

* Add 'title' attribute to iframe for accessibility [#3822](https://github.com/nextcloud/richdocuments/pull/3822)
* Allow passing css var to change Collabora logo color [#3854](https://github.com/nextcloud/richdocuments/pull/3854)

### Other

* Update nextcloud/ocp dependency [#3817](https://github.com/nextcloud/richdocuments/pull/3817)
* Update nextcloud/ocp dependency [#3847](https://github.com/nextcloud/richdocuments/pull/3847)

## 8.3.8

### Fixed

* Remove legacy Viewer code [#3729](https://github.com/nextcloud/richdocuments/pull/3729)
* Always pass is_admin property to userextrainfo [#3734](https://github.com/nextcloud/richdocuments/pull/3734)
* Use new property for admin user indication [#3752](https://github.com/nextcloud/richdocuments/pull/3752)
* Use new property for guest indication [#3760](https://github.com/nextcloud/richdocuments/pull/3760)
* Uncheck group limit in admin settings [#3765](https://github.com/nextcloud/richdocuments/pull/3765)
* Run move in lock scope of the user [#3773](https://github.com/nextcloud/richdocuments/pull/3773)

### Other

* Update nextcloud/ocp dependency [#3696](https://github.com/nextcloud/richdocuments/pull/3696)
* Update nextcloud/ocp dependency [#3723](https://github.com/nextcloud/richdocuments/pull/3723)
* Update nextcloud/ocp dependency [#3746](https://github.com/nextcloud/richdocuments/pull/3746)
* Update nextcloud/ocp dependency [#3770](https://github.com/nextcloud/richdocuments/pull/3770)

## 8.3.7

### Fixed

- test(open-pdf): open pdf with richdocuments via file-action [#3667](https://github.com/nextcloud/richdocuments/pull/3667)
- fix: Avoid triggering file list requests during handover to desktop client [#3687](https://github.com/nextcloud/richdocuments/pull/3687)
- fix: Do not set user id for guests [#3678](https://github.com/nextcloud/richdocuments/pull/3678)
- Test guest name setting [#3683](https://github.com/nextcloud/richdocuments/pull/3683)
- fix: Avoid loading file actions if app is disabled for users [#3674](https://github.com/nextcloud/richdocuments/pull/3674)

## 8.3.6

### Fixed

* refactor: move to office.vue component by @backportbot in https://github.com/nextcloud/richdocuments/pull/3616
* fix: redesign guest name picker and fix opening it for shared folders by @backportbot in https://github.com/nextcloud/richdocuments/pull/3641
* fix: chunk loading error by @elzody in https://github.com/nextcloud/richdocuments/pull/3648
* fix: file action to open PDFs with richdocuments when files_pdfviewer is enabled by @backportbot in https://github.com/nextcloud/richdocuments/pull/3650


**Full Changelog**: https://github.com/nextcloud/richdocuments/compare/v8.3.5...v8.3.6

## 8.3.5

### Fixed

- fix: Use Close_Session post message to properly end the Collabora editing before opening locally @backportbot[bot] [#3603](https://github.com/nextcloud/richdocuments/pull/3603)
- fix: Use wopi callback url for all urls handed over to Collabora @backportbot[bot] [#3584](https://github.com/nextcloud/richdocuments/pull/3584)

## 8.3.4
### Fixed
* fix(WopiController): In `putFile()` set editor user as user scope by @backportbot in https://github.com/nextcloud/richdocuments/pull/3560
* don't alter file when there is not enough free space by @backportbot in https://github.com/nextcloud/richdocuments/pull/3578


**Full Changelog**: https://github.com/nextcloud/richdocuments/compare/v8.3.3...v8.3.4

## 8.3.3

### Fixed

- fix: Close button should just exit for the edit local modal @backportbot[bot] [#3550](https://github.com/nextcloud/richdocuments/pull/3550)
- match dark theme of system if no nextcloud theme specified @backportbot[bot] [#3552](https://github.com/nextcloud/richdocuments/pull/3552)
- fix: Use new viewer api to open files again after open locally @backportbot[bot] [#3526](https://github.com/nextcloud/richdocuments/pull/3526)

## 8.3.2

### Fixed

- [stable28] fix: emit allow attribute on iframe for the clipboard (fixes #3474) @backportbot[bot] [#3481](https://github.com/nextcloud/richdocuments/pull/3481)
- [stable28] Fixes #3492 joining after document is renamed inside editor @backportbot[bot] [#3504](https://github.com/nextcloud/richdocuments/pull/3504)
- [stable28] fix: emit allow attribute on all iframes for the clipboard (related t… @backportbot[bot] [#3483](https://github.com/nextcloud/richdocuments/pull/3483)
- [stable28] fix: Properly use input model in settings text fields @backportbot[bot] [#3495](https://github.com/nextcloud/richdocuments/pull/3495)
- [stable28] Fix open locally with files lock and wopi allow list @backportbot[bot] [#3503](https://github.com/nextcloud/richdocuments/pull/3503)

### Other

- test(ci): use only 3 runners for cypress @max-nextcloud [#3411](https://github.com/nextcloud/richdocuments/pull/3411)

## 8.3.1

### Fixed

- fix: mention popup reappears after inserting the mention [#3365](https://github.com/nextcloud/richdocuments/pull/3365)
- fix: Use proper blob url for all fonts [#3362](https://github.com/nextcloud/richdocuments/pull/3362)
- fix: Avoid 3px offset on public share links [#3370](https://github.com/nextcloud/richdocuments/pull/3370)
- fix: Consider owner group membership for public share links [#3375](https://github.com/nextcloud/richdocuments/pull/3375)
- fix(Application.php): Update methods post-refactor [#3383](https://github.com/nextcloud/richdocuments/pull/3383)
- fix: Disable auto logout while editing [#3389](https://github.com/nextcloud/richdocuments/pull/3389)
- feat: add loadingMessage() to show different loadingMsg @juliushaertl [#3400](https://github.com/nextcloud/richdocuments/pull/3400)
- fix: Let wopi middleware also handle asset fetching [#3407](https://github.com/nextcloud/richdocuments/pull/3407)

## 8.3.0

### Added

- Add preview provider for emf files @kesselb [#3303](https://github.com/nextcloud/richdocuments/pull/3303)
- Improve setup checks and url handling with separate callback url [#3333](https://github.com/nextcloud/richdocuments/pull/3333)
- Ship default fonts [#3351](https://github.com/nextcloud/richdocuments/pull/3351)
- Nextcloud 28 compatibility
- Version support and iframe refactoring @juliushaertl [#3152](https://github.com/nextcloud/richdocuments/pull/3152)
- feat: add config option mobile_editing @luka-nextcloud [#3141](https://github.com/nextcloud/richdocuments/pull/3141)
- Exclude MSOffice mime types association if OnlyOffice app is installed @proxyconcept [#2301](https://github.com/nextcloud/richdocuments/pull/2301)
- Improve logging for WOPI Parser @R0Wi [#3252](https://github.com/nextcloud/richdocuments/pull/3252)
- Allow current user lock @ArtificialOwl [#3206](https://github.com/nextcloud/richdocuments/pull/3206)

### Fixed

- fix: Set proper user scope for direct editing @juliushaertl [#3293](https://github.com/nextcloud/richdocuments/pull/3293)
- fix: Avoid fetching webdav on public links @juliushaertl [#3296](https://github.com/nextcloud/richdocuments/pull/3296)
- fix: Set expect guzzle option to false @juliushaertl [#3298](https://github.com/nextcloud/richdocuments/pull/3298)
- fix: Fix version access with new version backend on shared files [#3339](https://github.com/nextcloud/richdocuments/pull/3339)
- fix: Make rename update the file list properly on files2vue [#3346](https://github.com/nextcloud/richdocuments/pull/3346)
- fix: Do not fail if node has no owner @juliushaertl [#3278](https://github.com/nextcloud/richdocuments/pull/3278)
- fix: Create empty files from template if available @juliushaertl [#3059](https://github.com/nextcloud/richdocuments/pull/3059)
- Fix document target picker and add slide support @juliushaertl [#3058](https://github.com/nextcloud/richdocuments/pull/3058)
- fix(Wopi): Mark sensitive parameter as such @nickvergessen [#3042](https://github.com/nextcloud/richdocuments/pull/3042)
- fix: Log invalid wopi tokens at info level instead of error @juliushaertl [#3107](https://github.com/nextcloud/richdocuments/pull/3107)
- Add tablet parm for Insert_Button @Darshan-upadhyay1110 [#3094](https://github.com/nextcloud/richdocuments/pull/3094)
- fix: Allow to opt-in loading image mimes on hide download shares @juliushaertl [#3137](https://github.com/nextcloud/richdocuments/pull/3137)
- fix: Use userId as a fallback for new file creation token @juliushaertl [#3177](https://github.com/nextcloud/richdocuments/pull/3177)
- fix: Mobile support shall be enabled by default @juliushaertl [#3184](https://github.com/nextcloud/richdocuments/pull/3184)
- fix: Properly provide instance id @juliushaertl [#3218](https://github.com/nextcloud/richdocuments/pull/3218)
- fix: Update file metadata after save @juliushaertl [#3230](https://github.com/nextcloud/richdocuments/pull/3230)
- fix dropdowns have wrong mark color in browsers @Darshan-upadhyay1110 [#3238](https://github.com/nextcloud/richdocuments/pull/3238)
- fix: Add proper feature policy @juliushaertl [#3237](https://github.com/nextcloud/richdocuments/pull/3237)
- fix: Clear loading timeout when guest name is asked @juliushaertl [#3256](https://github.com/nextcloud/richdocuments/pull/3256)
- Close NC sidebar on file open @Darshan-upadhyay1110 [#3259](https://github.com/nextcloud/richdocuments/pull/3259)
- fix: Properly update files app state when using saveAs @juliushaertl [#3277](https://github.com/nextcloud/richdocuments/pull/3277)
- fix: Disable pdf preview gnerator through Collabora if server already has support for it @juliushaertl [#3112](https://github.com/nextcloud/richdocuments/pull/3112)
- CollaboraOnline#6546 enable automatic color in default paragraph style @timar [#3103](https://github.com/nextcloud/richdocuments/pull/3103)
- fix: Provide valid fileList and fileId context on new file action @juliushaertl [#3114](https://github.com/nextcloud/richdocuments/pull/3114)
- fix: Revert change of extension which should refer to the new file extension @juliushaertl [#3115](https://github.com/nextcloud/richdocuments/pull/3115)
- fix: Use a proper empty xlsx file @juliushaertl [#3113](https://github.com/nextcloud/richdocuments/pull/3113)
- fix: Emit warning instead of info when WOIP request is denied @moan0s [#3261](https://github.com/nextcloud/richdocuments/pull/3261)

## 8.3.0-beta.2

### Added

- Add preview provider for emf files @kesselb [#3303](https://github.com/nextcloud/richdocuments/pull/3303)
- Improve setup checks and url handling with separate callback url [#3333](https://github.com/nextcloud/richdocuments/pull/3333)
- Ship default fonts [#3351](https://github.com/nextcloud/richdocuments/pull/3351)

### Fixed

- fix: Set proper user scope for direct editing @juliushaertl [#3293](https://github.com/nextcloud/richdocuments/pull/3293)
- fix: Avoid fetching webdav on public links @juliushaertl [#3296](https://github.com/nextcloud/richdocuments/pull/3296)
- fix: Set expect guzzle option to false @juliushaertl [#3298](https://github.com/nextcloud/richdocuments/pull/3298)
- fix: Fix version access with new version backend on shared files [#3339](https://github.com/nextcloud/richdocuments/pull/3339)
- fix: Make rename update the file list properly on files2vue [#3346](https://github.com/nextcloud/richdocuments/pull/3346)
- fix: Do not fail if node has no owner @juliushaertl [#3278](https://github.com/nextcloud/richdocuments/pull/3278)

## 8.3.0-beta.1

### Added

- Nextcloud 28 compatibility
- Version support and iframe refactoring @juliushaertl [#3152](https://github.com/nextcloud/richdocuments/pull/3152)
- feat: add config option mobile_editing @luka-nextcloud [#3141](https://github.com/nextcloud/richdocuments/pull/3141)
- Exclude MSOffice mime types association if OnlyOffice app is installed @proxyconcept [#2301](https://github.com/nextcloud/richdocuments/pull/2301)
- Improve logging for WOPI Parser @R0Wi [#3252](https://github.com/nextcloud/richdocuments/pull/3252)
- Allow current user lock @ArtificialOwl [#3206](https://github.com/nextcloud/richdocuments/pull/3206)

### Fixed

- fix: Create empty files from template if available @juliushaertl [#3059](https://github.com/nextcloud/richdocuments/pull/3059)
- Fix document target picker and add slide support @juliushaertl [#3058](https://github.com/nextcloud/richdocuments/pull/3058)
- fix(Wopi): Mark sensitive parameter as such @nickvergessen [#3042](https://github.com/nextcloud/richdocuments/pull/3042)
- fix: Log invalid wopi tokens at info level instead of error @juliushaertl [#3107](https://github.com/nextcloud/richdocuments/pull/3107)
- Add tablet parm for Insert_Button @Darshan-upadhyay1110 [#3094](https://github.com/nextcloud/richdocuments/pull/3094)
- fix: Allow to opt-in loading image mimes on hide download shares @juliushaertl [#3137](https://github.com/nextcloud/richdocuments/pull/3137)
- fix: Use userId as a fallback for new file creation token @juliushaertl [#3177](https://github.com/nextcloud/richdocuments/pull/3177)
- fix: Mobile support shall be enabled by default @juliushaertl [#3184](https://github.com/nextcloud/richdocuments/pull/3184)
- fix: Properly provide instance id @juliushaertl [#3218](https://github.com/nextcloud/richdocuments/pull/3218)
- fix: Update file metadata after save @juliushaertl [#3230](https://github.com/nextcloud/richdocuments/pull/3230)
- fix dropdowns have wrong mark color in browsers @Darshan-upadhyay1110 [#3238](https://github.com/nextcloud/richdocuments/pull/3238)
- fix: Add proper feature policy @juliushaertl [#3237](https://github.com/nextcloud/richdocuments/pull/3237)
- fix: Clear loading timeout when guest name is asked @juliushaertl [#3256](https://github.com/nextcloud/richdocuments/pull/3256)
- Close NC sidebar on file open @Darshan-upadhyay1110 [#3259](https://github.com/nextcloud/richdocuments/pull/3259)
- fix: Properly update files app state when using saveAs @juliushaertl [#3277](https://github.com/nextcloud/richdocuments/pull/3277)
- fix: Disable pdf preview gnerator through Collabora if server already has support for it @juliushaertl [#3112](https://github.com/nextcloud/richdocuments/pull/3112)
- CollaboraOnline#6546 enable automatic color in default paragraph style @timar [#3103](https://github.com/nextcloud/richdocuments/pull/3103)
- fix: Provide valid fileList and fileId context on new file action @juliushaertl [#3114](https://github.com/nextcloud/richdocuments/pull/3114)
- fix: Revert change of extension which should refer to the new file extension @juliushaertl [#3115](https://github.com/nextcloud/richdocuments/pull/3115)
- fix: Use a proper empty xlsx file @juliushaertl [#3113](https://github.com/nextcloud/richdocuments/pull/3113)
- fix: Emit warning instead of info when WOIP request is denied @moan0s [#3261](https://github.com/nextcloud/richdocuments/pull/3261)

### Other
- Bump dependencies
- Create pr-feedback.yml @max-nextcloud [#3051](https://github.com/nextcloud/richdocuments/pull/3051)
- ci(cypress): Fix selectors for files to vue @juliushaertl [#3123](https://github.com/nextcloud/richdocuments/pull/3123)
- test(cypress): Add test for share token direct editing @juliushaertl [#3160](https://github.com/nextcloud/richdocuments/pull/3160)
- ci(cypress): Bump github action @juliushaertl [#3234](https://github.com/nextcloud/richdocuments/pull/3234)
- chore(php): Add PHP 8.3 to test matrix @juliushaertl [#3253](https://github.com/nextcloud/richdocuments/pull/3253)

## 8.1.0-beta.1

### Added

- Support for Nextcloud 27

### Fixed

- Fix regression on share links as logged in users @juliushaertl [#2784](https://github.com/nextcloud/richdocuments/pull/2784)
- Fix viewer height on safari mobile @julien-nc [#2801](https://github.com/nextcloud/richdocuments/pull/2801)
- Fix base64 image generation @julien-nc [#2826](https://github.com/nextcloud/richdocuments/pull/2826)
- Fix issue when loading direct editing @juliushaertl [#2874](https://github.com/nextcloud/richdocuments/pull/2874)
- fix: Avoid error when browser cannot detect font mimetype @juliushaertl [#2893](https://github.com/nextcloud/richdocuments/pull/2893)
- Fix file templates on public links @juliushaertl [#2877](https://github.com/nextcloud/richdocuments/pull/2877)
- fix(files): Avoid reloading the file list and use update methods instead @juliushaertl [#2881](https://github.com/nextcloud/richdocuments/pull/2881)
- fix: Avoid setting user scope for share links @juliushaertl [#2899](https://github.com/nextcloud/richdocuments/pull/2899)
- Improve group multiselect behaviour with multiple and long group names @juliushaertl [#2944](https://github.com/nextcloud/richdocuments/pull/2944)
- allow to add ttf files @szaimen [#2782](https://github.com/nextcloud/richdocuments/pull/2782)
- Move document params to initial state @juliushaertl [#2258](https://github.com/nextcloud/richdocuments/pull/2258)
- fix: direct editing integration tests @juliushaertl [#2795](https://github.com/nextcloud/richdocuments/pull/2795)
- Workaround for en-AU language/locale @timar [#2841](https://github.com/nextcloud/richdocuments/pull/2841)
- fix: Trigger initial setup earlier @juliushaertl [#2846](https://github.com/nextcloud/richdocuments/pull/2846)
- fix(auto_logout): Register auto_logout listeners to prevent auto_logout while editing @marcelklehr [#2845](https://github.com/nextcloud/richdocuments/pull/2845)
- Hide close button on single file shares that have hide download enabled @sharonwuu [#2827](https://github.com/nextcloud/richdocuments/pull/2827)
- fix: Properly select save as dialog buttons @juliushaertl [#2880](https://github.com/nextcloud/richdocuments/pull/2880)
- String and test fixes @silopolis [#2901](https://github.com/nextcloud/richdocuments/pull/2901)
- Dependency updates

## 8.0.0-beta.1

### Added

- Add app config to override wopi checkFileInfo @juliushaertl [#2560](https://github.com/nextcloud/richdocuments/pull/2560)
- Implement user mentions API @Raudius [#2576](https://github.com/nextcloud/richdocuments/pull/2576)
- Add confirmation dialog after document is opened locally @Raudius [#2648](https://github.com/nextcloud/richdocuments/pull/2648)

### Fixed

- For PDFs rename context menu option to "Open with" @Raudius [#2527](https://github.com/nextcloud/richdocuments/pull/2527)
- Do not fail if no directory is passed when creating a file from a template @juliushaertl [#2543](https://github.com/nextcloud/richdocuments/pull/2543)
- Return proper status code if file is not found during writing @juliushaertl [#2537](https://github.com/nextcloud/richdocuments/pull/2537)
- Use proper product name in capabilities @juliushaertl [#2525](https://github.com/nextcloud/richdocuments/pull/2525)
- option to use new grouped saveas @pedropintosilva [#2551](https://github.com/nextcloud/richdocuments/pull/2551)
- Keep passing light theme values to Collabora as long as the dark mode is not available there @juliushaertl [#2550](https://github.com/nextcloud/richdocuments/pull/2550)
- Invoke read permission check to trigger terms of services when creating a token @juliushaertl [#2559](https://github.com/nextcloud/richdocuments/pull/2559)
- Fix redundant port number in url @mayswind [#2573](https://github.com/nextcloud/richdocuments/pull/2573)
- Improve error handling for global template uploads @juliushaertl [#2595](https://github.com/nextcloud/richdocuments/pull/2595)
- Listen for event during preview rendering and apply secure view options @juliushaertl [#2579](https://github.com/nextcloud/richdocuments/pull/2579)
- Adjust preview event name to BeforePreviewFetchedEvent @juliushaertl [#2588](https://github.com/nextcloud/richdocuments/pull/2588)
- Pass the proper target path/name for new files created through direct editing @juliushaertl [#2626](https://github.com/nextcloud/richdocuments/pull/2626)
- Increase timeout for preview generation @gitsan13 [#2623](https://github.com/nextcloud/richdocuments/pull/2623)
- Fix array access error when requesting preview while not having access to Collabora @juliushaertl [#2640](https://github.com/nextcloud/richdocuments/pull/2640)
- Move WOPI checks to the middleware @juliushaertl [#2669](https://github.com/nextcloud/richdocuments/pull/2669)
- Be less strict with splitting the wopi allow list @juliushaertl [#2692](https://github.com/nextcloud/richdocuments/pull/2692)
- Another attempt to work around Safari issues @juliushaertl [#2605](https://github.com/nextcloud/richdocuments/pull/2605)
- fix(viewer): Do not attempt to register file actions if not available @juliushaertl [#2713](https://github.com/nextcloud/richdocuments/pull/2713)
- fix: Open pdf files by default on share links if files_pdfviewer is disabled @juliushaertl [#2723](https://github.com/nextcloud/richdocuments/pull/2723)
- Load viewer scripts depending on share ownership @juliushaertl [#2745](https://github.com/nextcloud/richdocuments/pull/2745)
- Fix creating new files from user templates @juliushaertl [#2740](https://github.com/nextcloud/richdocuments/pull/2740)
- Show warning if "WOPI allow-list" not configured @Raudius [#2604](https://github.com/nextcloud/richdocuments/pull/2604)
- Adjust local editing button position in tabbed view @Raudius [#2597](https://github.com/nextcloud/richdocuments/pull/2597)
- Add logging for remote requests @juliushaertl [#2652](https://github.com/nextcloud/richdocuments/pull/2652)
- Fix the return type according to global definition @christianlupus [#2661](https://github.com/nextcloud/richdocuments/pull/2661)
- Remove deprecation warning if no access groups are defined @christianlupus [#2662](https://github.com/nextcloud/richdocuments/pull/2662)
- Valdnet patch 1 @Valdnet [#2656](https://github.com/nextcloud/richdocuments/pull/2656)
- introduce zotero integration for Nextcloud Office (Collabora Online) @lpranam [#2657](https://github.com/nextcloud/richdocuments/pull/2657)
- Log info message on wopi ip mismatch @juliushaertl [#2688](https://github.com/nextcloud/richdocuments/pull/2688)
- ci(integration): Use apcu and speed up basic auth @juliushaertl [#2712](https://github.com/nextcloud/richdocuments/pull/2712)
- Fix IPv6 handling in WOPI allow list @juliushaertl [#2696](https://github.com/nextcloud/richdocuments/pull/2696)
- minimal template.odg (locale agnostic) @timar [#2730](https://github.com/nextcloud/richdocuments/pull/2730)
- Add cypress tests @juliushaertl [#1939](https://github.com/nextcloud/richdocuments/pull/1939)
- Use private field for sharing Zotero key @eszkadev [#2726](https://github.com/nextcloud/richdocuments/pull/2726)
- l10n: Unified spelling and removed spaces @Valdnet [#2756](https://github.com/nextcloud/richdocuments/pull/2756)
- perf(autoloader): Add composer autoloader @juliushaertl [#2768](https://github.com/nextcloud/richdocuments/pull/2768)
- Rename main Git development branch from `master` to `main` @mejo- [#2761](https://github.com/nextcloud/richdocuments/pull/2761)
- Avoid exception when uploading epub @eszkadev [#2767](https://github.com/nextcloud/richdocuments/pull/2767)
- chore(CI): Update master php testing versions and workflow templates @nickvergessen [#2760](https://github.com/nextcloud/richdocuments/pull/2760)

## 7.0.0-beta.1

### Added
- Nextcloud 25 support
- Give better hints on a protocol mismatch with the discovery endpoint @juliushaertl [#2371]
- Emmit open event for each user on document open @juliushaertl [#2350]
- Upload custom fonts from admin interface @eneiluj [#2032]
- Token TTL app config value which sets expiration the WOPI token @Raudius [#2171]
- Optimised avatar request @juliushaertl [#2269]

## 6.2.0

### Added
- Allow download prevention on user shares @eneiluj [#2280](https://github.com/nextcloud/richdocuments/pull/2280)

### Fixed
- Limit capabilities to users that are enabled @juliushaertl [#2328](https://github.com/nextcloud/richdocuments/pull/2328)
- Fix saving issue when a file is available multiple times in a users home folder @juliushaertl [#2330](https://github.com/nextcloud/richdocuments/pull/2330)
- Cleanup Content Security Policy handling @juliushaertl [#2234](https://github.com/nextcloud/richdocuments/pull/2234)
- Fix double-header on public links @marcelklehr [#2312](https://github.com/nextcloud/richdocuments/pull/2312)
- Fix HTML entities showing in file names @Raudius [#2318](https://github.com/nextcloud/richdocuments/pull/2318)
- Restored "Open with Nextcloud Office" option from context menu @Raudius [#2318](https://github.com/nextcloud/richdocuments/pull/2318)

## 6.1.1

### Fixed

- Fix filename encoding issues @juliushaertl [#2261](https://github.com/nextcloud/richdocuments/pull/2261)

### Other

- add "is_guest" to extra info user data [#2244](https://github.com/nextcloud/richdocuments/pull/2244)

## 6.1.0

### Added
- Added support for file locking @juliushaertl [#2104](https://github.com/nextcloud/richdocuments/pull/2104)

### Fixed
- Optimised audit triggering @juliushaertl [#1957](https://github.com/nextcloud/richdocuments/pull/1957)
- Fixed viewer styling @juliushaertl [#2221](https://github.com/nextcloud/richdocuments/pull/2221) [#2212](https://github.com/nextcloud/richdocuments/pull/2212)
- Disabled remote image insertion on public links @juliushaertl [#2175](https://github.com/nextcloud/richdocuments/pull/2175)
- Fixed file revision behaviour on group folders @Raudius [#2172](https://github.com/nextcloud/richdocuments/pull/2197)


## 6.0.0

### Added

- Expose guest avatar images through wopi @juliushaertl [#1883](https://github.com/nextcloud/richdocuments/pull/1883)
- add "is_admin" to extra info user data @hcvcastro [#1810](https://github.com/nextcloud/richdocuments/pull/1810)
- Change wording from "New graphic" to "New diagram" @juliushaertl [#2031](https://github.com/nextcloud/richdocuments/pull/2031)
- Created a minimal otg file @Ezinnem [#2130](https://github.com/nextcloud/richdocuments/pull/2130)
- Adjust template preview ratio [#2154](https://github.com/nextcloud/richdocuments/pull/2154)
- Compatibility with Nextcloud 24

### Fixed

- Properly check proxy status @juliushaertl [#1900](https://github.com/nextcloud/richdocuments/pull/1900)
- Add addScript viewer dependency @juliushaertl [#1937](https://github.com/nextcloud/richdocuments/pull/1937)
- Do not load template directories twice @juliushaertl [#1794](https://github.com/nextcloud/richdocuments/pull/1794)
- Move filetype styles to separate css file and load it with viewer @juliushaertl [#1938](https://github.com/nextcloud/richdocuments/pull/1938)
- Ensure that the guest name picker is shown on editable links @juliushaertl [#1945](https://github.com/nextcloud/richdocuments/pull/1945)
- Don't wait DOMContentLoaded to register the viewer handler @eneiluj [#1959](https://github.com/nextcloud/richdocuments/pull/1959)
- Switch from iconv to mb_convert_encoding @Keessaus [#1967](https://github.com/nextcloud/richdocuments/pull/1967)
- Use FileCreatedFromTemplateEvent to inject the already existing empty templates @juliushaertl [#1377](https://github.com/nextcloud/richdocuments/pull/1377)
- Avoid too specific psalm annotation @juliushaertl [#2015](https://github.com/nextcloud/richdocuments/pull/2015)
- Fix frame absolute position in public file share @eneiluj [#2014](https://github.com/nextcloud/richdocuments/pull/2014)
- Always add gs.trustedHosts to the CSP @juliushaertl [#1977](https://github.com/nextcloud/richdocuments/pull/1977)
- Map es-419 to es-MX @juliushaertl [#2054](https://github.com/nextcloud/richdocuments/pull/2054)
- 🐛 Fix CSP violation when Nextcloud server has so-called 'service root' @ldidry [#2051](https://github.com/nextcloud/richdocuments/pull/2051)
- Do not hide speadsheet statusbar by default @juliushaertl [#2053](https://github.com/nextcloud/richdocuments/pull/2053)
- Adapt branding css variables @juliushaertl [#2069](https://github.com/nextcloud/richdocuments/pull/2069)
- Fix: missing settings messages @vinicius73 [#2095](https://github.com/nextcloud/richdocuments/pull/2095)
- Allow MS Office template file extensions for TemplateSource usage @juliushaertl [#2110](https://github.com/nextcloud/richdocuments/pull/2110)
- Fixes CSP on Nextcloud installations not on root directory @Raudius [#2126](https://github.com/nextcloud/richdocuments/pull/2126)
- Add app config to enable trusted domain list usage [#2163](https://github.com/nextcloud/richdocuments/pull/2163)
- Add gs.trustedHosts to form-action csp [#2160](https://github.com/nextcloud/richdocuments/pull/2160)
- Let integration tests pass again @juliushaertl [#2141](https://github.com/nextcloud/richdocuments/pull/2141)
- Keep mime-type indices consecutive. [#2174](https://github.com/nextcloud/richdocuments/pull/2174)
- Replace deprecated OC functions by @nextcloud/* npm pkgs ones @eneiluj [#2036](https://github.com/nextcloud/richdocuments/pull/2036)
- fix: template.odg file must be real odg file @merttumer [#2127](https://github.com/nextcloud/richdocuments/pull/2127)
- Update dependencies


## 4.2.3

### Fixed

- #1760 Unify error messages accross controllers
- #1728 Prevent not-needed early loading of the richdocuments app

### Other

- Dependency updates



## 4.2.2

### Added

- #1711 Allow guests to request a direct token for share links @juliushaertl

### Fixed

- #1707 Show avatar list if hide download is enabled @juliushaertl
- #1710 Another attempt to fix height setting for Safari issues on iOS @juliushaertl
- #1709 Give the avatar popover a proper z-index for public pages @juliushaertl

### Dependencies

- #1685 Bump @babel/core from 7.14.6 to 7.14.8 @dependabot[bot]
- #1700 Bump vue-loader from 15.9.7 to 15.9.8 @dependabot[bot]
- #1693 Bump sass from 1.36.0 to 1.37.0 @dependabot[bot]
- #1676 Bump @babel/preset-env from 7.14.7 to 7.14.8 @dependabot[bot]
- #1690 Bump eslint-plugin-vue from 7.14.0 to 7.15.0 @dependabot[bot]
- #1697 Bump @babel/preset-env from 7.14.8 to 7.14.9 @dependabot[bot]
- #1694 Bump eslint from 7.31.0 to 7.32.0 @dependabot[bot]
- #1695 Bump webpack from 5.46.0 to 5.47.1 @dependabot[bot]
- #1706 Bump @babel/plugin-transform-runtime from 7.14.5 to 7.15.0 @dependabot[bot]
- #1691 Bump @nextcloud/webpack-vue-config from 4.0.3 to 4.1.0 @dependabot[bot]
- #1702 Bump sass from 1.37.0 to 1.37.5 @dependabot[bot]
- #1705 Bump @babel/core from 7.14.8 to 7.15.0 @dependabot[bot]
- #1701 Bump eslint-plugin-vue from 7.15.0 to 7.15.1 @dependabot[bot]
- #1715 Bump psalm/phar from 4.8.1 to 4.9.2 @dependabot[bot]
- #1708 Bump webpack from 5.47.1 to 5.50.0 @dependabot[bot]
- #1703 Bump @babel/plugin-transform-modules-commonjs from 7.14.5 to 7.15.0 @dependabot[bot]
- #1712 Bump @babel/eslint-parser from 7.14.7 to 7.15.0 @dependabot[bot]
- #1714 Bump @babel/preset-env from 7.14.9 to 7.15.0 @dependabot[bot]
- #1713 Bump eslint-plugin-vue from 7.15.1 to 7.16.0 @dependabot[bot]
- #1716 Bump eslint-plugin-import from 2.23.4 to 2.24.0 @dependabot[bot]
- #1725 Bump psalm/phar from 4.9.2 to 4.9.3 @dependabot[bot]
- #1723 Bump sass from 1.37.5 to 1.38.0 @dependabot[bot]
- #1727 Bump webpack-cli from 4.7.2 to 4.8.0 @dependabot[bot]
- #1726 Bump eslint-plugin-import from 2.24.0 to 2.24.1 @dependabot[bot]
- #1724 Bump webpack from 5.50.0 to 5.51.1 @dependabot[bot]


## 4.2.1

* [#1655](https://github.com/nextcloud/richdocuments/pull/1655) Keep DownloadAsPostMessage when "saving as" documents @mikekaganski
* [#1663](https://github.com/nextcloud/richdocuments/pull/1663) Throttle on invalid share tokens @LukasReschke
* [#1664](https://github.com/nextcloud/richdocuments/pull/1664) Check for share token permissions @juliushaertl
* [#1674](https://github.com/nextcloud/richdocuments/pull/1674) L10n: Change to uppercase @Valdnet


## 4.2.0

* [#1638](https://github.com/nextcloud/richdocuments/pull/1638) Fix opening files when groupfolder ACL has revoked share permissions @juliushaertl
* [#1640](https://github.com/nextcloud/richdocuments/pull/1640) Allow to limit wopi requests to specific source hosts @juliushaertl
* [#1642](https://github.com/nextcloud/richdocuments/pull/1642) L10n: Correct a typo @Valdnet

## 4.1.2

* Nextcloud 22 compatibility

## 4.1.1

* [#1546](https://github.com/nextcloud/richdocuments/pull/1546) Fix wrong parameters set when creating a file from a template id @juliushaertl
* [#1559](https://github.com/nextcloud/richdocuments/pull/1559) Fix PutRelativeFile as non-owner @juliushaertl
* [#1544](https://github.com/nextcloud/richdocuments/pull/1544) Retry to check if Collabora is configured @eszkadev


## 4.1.0

* [#1512](https://github.com/nextcloud/richdocuments/pull/1512) Enhanced federated editing
* [#1446](https://github.com/nextcloud/richdocuments/pull/1446) Setup FeaturePolicy to allow fullscreen @eszkadev
* [#1459](https://github.com/nextcloud/richdocuments/pull/1459) Reload file name for share feature after Save As @eszkadev
* [#1465](https://github.com/nextcloud/richdocuments/pull/1465) Fix OOXML template extension @tiredofit
* [#1471](https://github.com/nextcloud/richdocuments/pull/1471) Fix duplicate document templates
* [#1485](https://github.com/nextcloud/richdocuments/pull/1485) L10n: Unify spelling @Valdnet
* [#1488](https://github.com/nextcloud/richdocuments/pull/1488) Improve parsing of guest name cookie
* [#1501](https://github.com/nextcloud/richdocuments/pull/1501) Add federation/direct editing tests
* [#1502](https://github.com/nextcloud/richdocuments/pull/1502) Do not use libxml_disable_entity_loader on PHP 8 or later
* [#1513](https://github.com/nextcloud/richdocuments/pull/1513) Don't cache empty capabilities @eszkadev
* [#1514](https://github.com/nextcloud/richdocuments/pull/1514) Work around safari having a inproper 100vh value
* [#1517](https://github.com/nextcloud/richdocuments/pull/1517) Use proper initiator url
* [#1528](https://github.com/nextcloud/richdocuments/pull/1528) Emit WOPI postmessages through the nextcloud event bus

## 4.0.4

* [#1443](https://github.com/nextcloud/richdocuments/pull/1443) Use correct config for GS info

## 4.0.3

* [#1416](https://github.com/nextcloud/richdocuments/pull/1416) Pass through UI_Share message if used in the version viewer
* [#1418](https://github.com/nextcloud/richdocuments/pull/1418) Allow revision viewer to enter full screen
* [#1422](https://github.com/nextcloud/richdocuments/pull/1422) Properly handle ooxml with the new template mechanism


## 4.0.2

* [#1374](https://github.com/nextcloud/richdocuments/pull/1374) Make sure that the same host remote is always considered as trusted
* [#1394](https://github.com/nextcloud/richdocuments/pull/1394) Improve dark theme experience @mwalbeck
* [#1396](https://github.com/nextcloud/richdocuments/pull/1396) Avoid determination of document editor in per-user-encryption setups @marioklump
* [#1397](https://github.com/nextcloud/richdocuments/pull/1397) Emit events on frontend states
* [#1401](https://github.com/nextcloud/richdocuments/pull/1401) Assets: Use octet-stream and attachment instead of allowing to inline display
* [#1412](https://github.com/nextcloud/richdocuments/pull/1412) Trim duplicate trailing slashes in wopi url
* [#1414](https://github.com/nextcloud/richdocuments/pull/1414) Add docs and sharingToken to the events

## 4.0.1

* [#1385](https://github.com/nextcloud/richdocuments/pull/1385) Fix opening files after creating them from a template
* [#1378](https://github.com/nextcloud/richdocuments/pull/1378) Use https for fetching the demo servers
* [#1382](https://github.com/nextcloud/richdocuments/pull/1382) Add proper return values to occ commands

## 4.0.0

* [#1317](https://github.com/nextcloud/richdocuments/pull/1317) Nextcloud 21 compatibility @juliushaertl
* [#1353](https://github.com/nextcloud/richdocuments/pull/1353) Apply new file name after rename @eszkadev

## 3.7.14

* [#1331](https://github.com/nextcloud/richdocuments/pull/1331) Log the exception so we know what is actually failing @rullzer
* [#1332](https://github.com/nextcloud/richdocuments/pull/1332) Use https by default for the federation service @rullzer
* [#1337](https://github.com/nextcloud/richdocuments/pull/1337) Properly handle cached failed requests in the Federation service @rullzer
* Update dependencies

## 3.7.13

* [#1326](https://github.com/nextcloud/richdocuments/pull/1326) Do not update CSP on calls to files_sharing @rullzer
* [#1327](https://github.com/nextcloud/richdocuments/pull/1327) Handle errors when fetching remote file info more gracefully @juliushaertl
* [#1329](https://github.com/nextcloud/richdocuments/pull/1329) Move federation cache to a distributed one @juliushaertl

## 3.7.12

* [#1178](https://github.com/nextcloud/richdocuments/pull/1178) Show error if trying to open a file on session credential based external storage @juliushaertl
* [#1279](https://github.com/nextcloud/richdocuments/pull/1279) Actually mark wopi entity fields as updated @juliushaertl
* [#1284](https://github.com/nextcloud/richdocuments/pull/1284) Rename document on save as success @eszkadev
* [#1303](https://github.com/nextcloud/richdocuments/pull/1303) Cut of guest names so they fit into the database @nickvergessen
* [#1305](https://github.com/nextcloud/richdocuments/pull/1305) Properly trim trailing slashes from the remote url @juliushaertl
* [#941](https://github.com/nextcloud/richdocuments/pull/941) Be fair about compatiblity of this module @mmaridev
* Update dependencies

## 3.7.11

* [#1256](https://github.com/nextcloud/richdocuments/pull/1256) Adapt built-in CODE url on host address change @mrkara
* [#1269](https://github.com/nextcloud/richdocuments/pull/1269) Increase timeout if proxy is starting @eszkadev
* [#1277](https://github.com/nextcloud/richdocuments/pull/1277) Check proxy status on timeout @eszkadev
* [#1278](https://github.com/nextcloud/richdocuments/pull/1278) Fix possible issues with remote editing
* [#989](https://github.com/nextcloud/richdocuments/pull/989) Show hint about missing capabilities endpoint connection

## 3.7.10

* [#1257](https://github.com/nextcloud/richdocuments/pull/1257) Try to obtain the appdata folder in 1 go @rullzer
* [#1258](https://github.com/nextcloud/richdocuments/pull/1258) Fix compatibility issue with Nextcloud 15 @juliushaertl
* [#1259](https://github.com/nextcloud/richdocuments/pull/1259) Don't use a stream response on an empty file @rullzer
* [#1266](https://github.com/nextcloud/richdocuments/pull/1266) Fix issues with federated editing in global scale setups @juliushaertl
* [#1268](https://github.com/nextcloud/richdocuments/pull/1268) Fix typo when refetching discovery @eszkadev

## 3.7.9

## Fixed

* [#1238](https://github.com/nextcloud/richdocuments/pull/1238) Move to @nextcloud/capabilities and only register default mime types for viewer
* [#1239](https://github.com/nextcloud/richdocuments/pull/1239) Fix compatibility to oracle as a database
* [#1240](https://github.com/nextcloud/richdocuments/pull/1240) Add two more useful placeholders for watermark text @timar
* [#1242](https://github.com/nextcloud/richdocuments/pull/1242) Add French (Switzerland) and Italian (Switzerland) as special case @timar
* [#1243](https://github.com/nextcloud/richdocuments/pull/1243) Add migration to bigint columns
* [#1244](https://github.com/nextcloud/richdocuments/pull/1244) Do not fail if capabilities have not been fetched for the built-in server


## 3.7.8

### Added

* [#1237](https://github.com/nextcloud/richdocuments/pull/1237) Make frame loading timeout configurable through occ

## 3.7.7

### Added

* [#1220](https://github.com/nextcloud/richdocuments/pull/1220) Support opening visio files @timar
* [#1221](https://github.com/nextcloud/richdocuments/pull/1221) Add close method for mobile app integration @juliushaertl

### Fixed

* [#1222](https://github.com/nextcloud/richdocuments/pull/1222) Adjust ui_defaults do be the same across different document types @juliushaertl
* [#1226](https://github.com/nextcloud/richdocuments/pull/1226) Move Collabora endpoint caching to distributed cache @juliushaertl

## 3.7.6

### Added
* [#1211](https://github.com/nextcloud/richdocuments/pull/1211) Passing some UI Defaults to loleaflet frame @merttumer

### Fixed
* [#1198](https://github.com/nextcloud/richdocuments/pull/1198) Use correct call to notify mobile @eszkadev
* [#1210](https://github.com/nextcloud/richdocuments/pull/1210) Fix escaping for edit with message @gary-kim


## 3.7.5

### Added
* [#1137](https://github.com/nextcloud/richdocuments/pull/1137) Add occ richdocuments:activate-config to autoprovision Collabora configurations @ebardie
* [#974](https://github.com/nextcloud/richdocuments/pull/974) Add frontend hooks and expose config/open methods @juliushaertl

### Bugfixes

* [#1055](https://github.com/nextcloud/richdocuments/pull/1055) Fix bug #1054 @SamKer
* [#1095](https://github.com/nextcloud/richdocuments/pull/1095) Make 'Remove user' label localizable @timar
* [#1111](https://github.com/nextcloud/richdocuments/pull/1111) Updated presentation template. @kendy
* [#1133](https://github.com/nextcloud/richdocuments/pull/1133) Use proper base template to be compatible with Nextcloud 20 @juliushaertl
* [#1150](https://github.com/nextcloud/richdocuments/pull/1150) Arm64: Allow auto-enabling Built-in CODE Server on ARM64 @mrkara
* [#1152](https://github.com/nextcloud/richdocuments/pull/1152) Properly check value types when updating watermark settings @juliushaertl
* [#1153](https://github.com/nextcloud/richdocuments/pull/1153) Very minimal document templates for Collabora Online @timar
* [#1154](https://github.com/nextcloud/richdocuments/pull/1154) Use PHP_OS instead of PHP_OS_FAMILY when PHP version < 7.2 @mrkara
* [#1162](https://github.com/nextcloud/richdocuments/pull/1162) Arm64 adaptations @mrkara
* [#1163](https://github.com/nextcloud/richdocuments/pull/1163) Fix platform mismatch error message @mrkara
* [#1164](https://github.com/nextcloud/richdocuments/pull/1164) Do not use isset for checking the class constant @juliushaertl
* [#1169](https://github.com/nextcloud/richdocuments/pull/1169) Template sourced documents support DownloadAsPostMessage @Ashod
* [#1170](https://github.com/nextcloud/richdocuments/pull/1170) No need to get the avatar image since we have one for each user @juliushaertl
* [#1174](https://github.com/nextcloud/richdocuments/pull/1174) Update location of screenshots @timar
* [#1180](https://github.com/nextcloud/richdocuments/pull/1180) Ensures <iframe> contains a non-empty title attribute @pedropintosilva
* [#1192](https://github.com/nextcloud/richdocuments/pull/1192) Lint fix @R0Wi
* [#1194](https://github.com/nextcloud/richdocuments/pull/1194) Use base template for direct editing @juliushaertl
* [#1195](https://github.com/nextcloud/richdocuments/pull/1195) The mobile apps need to handle the hyperlinks themselves. @kendy

## 3.7.4

* Nextcloud 20 compatibility
* [#1055](https://github.com/nextcloud/richdocuments/pull/1055) Fix migrations for missing table columns @SamKer
* [#1077](https://github.com/nextcloud/richdocuments/pull/1077) Hide sharing menu if no share permission is set @juliushaertl
* [#1078](https://github.com/nextcloud/richdocuments/pull/1078) Hide revision history menu on public pages @juliushaertl
* [#1095](https://github.com/nextcloud/richdocuments/pull/1095) Make 'Remove user' label localizable @timar
* [#1111](https://github.com/nextcloud/richdocuments/pull/1111) Updated presentation template. @kendy


## 3.7.3

### Fixed
* [#1023](https://github.com/nextcloud/richdocuments/pull/1023) Fix saving 'disable certificate verification' @CySlider
* [#1059](https://github.com/nextcloud/richdocuments/pull/1059) Fix issue with custom trusted certificates not being applied
* [#1061](https://github.com/nextcloud/richdocuments/pull/1061) Fix not found error when opening share links with edit permission
 

## 3.7.2

### Fixed

* [#1052](https://github.com/nextcloud/richdocuments/pull/1052) Fix regression caused documents to not load

## 3.7.1


### Fixed

* [#1010](https://github.com/nextcloud/richdocuments/pull/1010) Advise installation via 'occ' if it fails from the web interface. @kendy
* [#1015](https://github.com/nextcloud/richdocuments/pull/1015) String update for built-in CODE option @mrkara
* [#1017](https://github.com/nextcloud/richdocuments/pull/1017) Handling of a new error state from proxy.php?status. @kendy
* [#1020](https://github.com/nextcloud/richdocuments/pull/1020) Check for read permission on the file actions @juliushaertl
* [#1022](https://github.com/nextcloud/richdocuments/pull/1022) Update install.md @juliushaertl
* [#1024](https://github.com/nextcloud/richdocuments/pull/1024) Update screenshots @timar
* [#1026](https://github.com/nextcloud/richdocuments/pull/1026) New error state to handle - running on non-glibc based Linux. @kendy
* [#885](https://github.com/nextcloud/richdocuments/pull/885) Move to @nextcloud packages @juliushaertl
* [#1038](https://github.com/nextcloud/richdocuments/pull/1038) Fix issues with Nextcloud 15/16 @juliushaertl


## 3.7.0

### Added
- Add support for built-in CODE server
- Inform user about web server configuration issues
- Document templates: use only one sans-serif font family
- Viewer integration

### Fixed
- Fix CSP violation when collabora server has so-called 'service root'
- Allow connecting to local addresses
- Avoid duplicate save requests
- Avoid additional HTTP request on the files app
- Reduce requests for loaded CSS files
- Fix certificate validation handling
- Be more robust on paths that don't start with a slash
- Bring back IE11 support

## 3.6.0

### Added
- Add demo server selector and show hint about that when Collabora is not setup

### Fixed
- Fix filesystem setup that caused save issues all over the place
- Do not try to recreate a file from a template more than once
- Do not open PDF files by default
- Dependency bumps

## 3.5.1

### Fixed
- Fix issue when shared files were not creating activity/version entries
- Fix bug on public share links
- Dependency bumps

## 3.5.0

### Added

- Implement support for TemplateSource file creation method
- Add occ command to update template files

### Fixed

- Fix inserting images with groupfolders that have ACL configured
- Fix setting cache values when editing federated (@xklonx)
- Dependency bumps

## 3.4.6

### Added
- Force read operation to trigger audit log when issuing a token
- Nextcloud 18 compatibility

## 3.4.5

### Fixed
- Retry putContent operation if locked
- Include locale in the loleaflet lang parameter
- Make sure files created from the same template have a different WOPI file id
- Always use the owner file owner to access for share links
- Make sure Firefox doesn't navigate out of the current directory
- Dependency bumps


## 3.4.4

### Fixed
- Fix issue when creating files from templates
- Make sure files are properly opened after creation


## 3.4.3

### Fixed
- Update translations
- Bump dependencies
- Always open CSV files with collabora (#671)
- Do not use template shipped by core (#670)
- Fix undefined index warning (#652)
- Check key before accessing (#645)
- Move file list access to files app integration (#651)
- Lower log level if the token does not exist (#653)

## 3.4.2

### Fixed
- Remove unneeded logging
- Restore IE11 compatibility
- Fix group selector in settings
- Use Collabora for secure view of images
- Update dependencies

## 3.4.1

### Fixed

- Fix compatibility with PHP 7.0
- Fix bug when federation app was disabled

## 3.4.0

### Added

- Federated document editing
- Watermarking

### Fixed

- General frontend refactoring to fix flaws in files app integration and performance issues
- Check for type when uploading a template
- Use proper public url instead of regular wopi endpoint to fix issues in locked down environments
- Open file directly if only one template is available

## 3.3.15

### Fixed
- Check for file in editor folder only when available
- Add check to only open one document at a time

## 3.3.14

### Fixed
- Pass paste postmessage from collabora to mobile apps
- Fix preview generation on Nextcloud 17 

## 3.3.13

### Fixed
- Improve loading time when opening documents
- Fix admin settings not saving properly

## 3.3.12

### Fixed
- Fix regression from 3.3.11 without URL rewriting

## 3.3.11

### Fixed
- Fix different wopisrc for the same file with loadbalanced collabora instances

## 3.3.10

### Fixed
- Hide full screen button in mobile apps
- Implement message for supporting download as / print in mobile apps

## 3.3.9

### Fixed
- Pass file renaming message to mobile apps
- Only allow view removal for file owners
- Allow clients to trigger Grab_Focus

## 3.3.8

### Fixed
- Fix UI rescaling in webkit
- Fix scrolling behavior on webkit
- Implement support for file renaming
- Allow to use MS Office template formats

## 3.3.7

### Fixed
- Implement new Views_List message
- Allow accessing the Save As web UI on mobile
- Allow UTF8 characters in filenames when creating documents from mobile

## 3.3.6

### Fixed
- Ship new empty presentation template
- Add migration step to replace empty templates after upgrade 

## 3.3.5

### Fixed
- Only allow closing other views with write permissions

## 3.3.4

### Fixed
- Don't generate preview for empty files
- Copy file to temp file for encrypted / object storage
- Remove ghost avatars #462
- Use "Guestname (Guest)" so that names are more distinguishable
- Use actual user id if a logged in user browses a public share link
- Improved logging
- Replace deprecated javascript calls

## 3.3.3

### Fixed
- Avoid scrolling if iframe is visible
- Return proper product name if it is provided
- Fix searching in groups with other user backends

## 3.3.2

### Fixed
- Use valid HTTP status codes
- Fix undefined variable when creating tokens

## 3.3.1

### Fixed
- Bug fix for syntax error on PHP 7.0

## 3.3.0

### Added

- Use product name from collabora capabilities
- Add hide download support for share links
- Use collabora to generate PDF previews
- Better mimetype handling for mobile editing

### Fixed

- Set timeout for editor inactivity
- Set proper extension when creating ooxml files from templates
- Do not open SVG files with collabora by default
- Hide collabora user list on desktop browsers

## 3.2.4

### Fixed

- Only update capabilities on successfull fetch
- Increase timeout when fetching capabilities
- Fix translations on file actions
- Only try to generate previews if convert-to is available
- Trigger favorite action properly
- Set proper nonce on the outer iframe
- Fix guest name input

## 3.2.3

### Fixed
- Check properly if we are in direct editing
- Fix undefined index log warnings
- Fix multipart data when requesting reviews
- Handle UI_Share postmessage from collabora

## 3.2.2

### Added
- Add option to disable certificate validation

### Fixed
- Fix various errors when interacting with the files app
- Show last saved version in the version sidebar
- Make sure the window title is set properly
- Improve admin settings layout
- Allow to uncheck follow current user
- Fix template previews
- Use Nextcloud language instead of locale

## 3.2.1

### Fixed
- Fix issues with mobile editing
- Restore IE11 compatibility
- Hide sidebar when closing the version viewer
- Fix issue when fetching the file model
- Scale Collabora frame to 100% height on mobile
- Updated translations and fix issues with untranslated text

## 3.2.0
- Added: File actions menu in the header
- Added: Handle UI_CreateFile post message
- Added: Handle unreachable collabora instance
- Added: Load capabilities in a background job
- Fixed: Pass proper response to registerFilesMenu
- Fixed: Translation for Insert images
- Fixed: Remove language settings from templates
- Fixed: Better wording for the image file picker
- Fixed: Use first template if none is selected
- Fixed: Proper scroll behaviour on Nextcloud 14/15
- Fixed: Create new text documents from within collabora
- Fixed: Use proper templates on old collabora versions
- Fixed: Convert nextcloud locale to BCP47 languages tag correctly

## 3.1.1
- Fixed: Capabilities fetching when no url is entered
- Fixed: Capabilities timeout of 5 seconds
- Fixed: NC13 compatibility due to missing js capabilities
- Changed: Updated translations

## 3.1.0
- Added: Template picker (if supported by COOL)
- Added: Mobile editing support capability
- Added: Version integration with the Nextcloud sidebar

## 3.0.6
- Added: NC16 compatibility
- Fixed: Translations
- Fixed: NC15 grid view toggle overlay

## 3.0.5
- Fixed: Pass UID for direct tokens (#301)
- Fixed: Do not show nextcloud bar on small screens (#306)
- Fixed: Avatar improvements for editing users (#304)
- Fixed: show password overlay properly (#308)

## 3.0.4
- Fixed: Make php5.6 compatible again (#297)

## 3.03
- Added: Notify clients when page is fully loaded (#291)
- Fixed: Do not show spinner if we nickname chose is visible (#293)
- Fixed:  Disable the vertical swipe to reload gesture (#295)

## 3.0.2
- Fixes: Only show document overlay when document is fully loaded (#283)
- Fixes: Generate assertUrl link with generateurl, so it also works in subfolder installations (#288)
- Fixes: Show displayname on avatar hover (#289)
- Fixes: Do not clear assets on HEAD request (#290)

## 3.0.1
- Fixes: Do not show loading spinner overlay public page if we need a username
- Fixes: Do not duplicate avatars in the top overlay

## 3.0.0
- Bug: use editor to save the user (fixes #184)
- Bug: allow creation of OOXML files if app not in default location (fixes #118)
- Bug: center public edit name

- Fixes: Do not use deprecated OC.webroot
- Fixes: Move to compiled handlebars tempalte to be strict CSP compatible
- Fixes: Do not show building of the interface

- Feature: Allow inserting images directly from Nextcloud
- Feature: Add sharing button to header
- Feature: Use Collabora as a preview provider
- Feature: Show editors in Nextcloud header


## 1.12.38 and 1.12.39
- Bug: fix z-index issue on Nextcloud 13 beta

## 1.12.37
- Feature: Add support for PutRelativeFile for Save As.

## 1.12.36
- Feature: Add avatar to UserExtraInfo (from NC 13)
- Feature: Start listening for standard post messages and ignore deprecated ones
- Feature: Add option to enable the app only for users in a specific group
- Updated translations

## 1.12.35
- Feature: Support for external apps. External apps can now generate a secret token to access richdocuments public API.

## 1.12.34
- Bug: Fix editing publicly shared documents
- Bug: Delete creator/last modifier name from document templates

## 1.12.33
- Feature: Restore 'Enable edit for specific groups' feature, fixes #66
- Feature: Only edit textfiles with Collabora Online, when texteditorapp is disabled
- Feature: Include support for X-LOOL-WOPI-Timestamp
- Bug: Undefined variable 'owneruid'

## 1.12.32
- Bug: Show Display Name of user, not its uid in userlist
- Bug: Do not throw exception when user not found. It might be a public link share.
- Bug: Use the file owner from the share object, if available. Fixes #85.
- Bug: Shorter db index name. Fixes #54.

## 1.12.31
- Bug: Guard encryption support

## 1.12.30
- Feature: Support opening encrypted files
- Bug: Respect OOXML settings again
- Bug: Register the change under user’s name when saving the document

## 1.12.29
- Bug: Fix undefined instanceId

## 1.12.28
- Bug: Allow full screen
- Updated screenshots
- Updated translations

## 1.12.27
- Bug: Fix revision history

## 1.1.26
- Bug: Set the correct language tag expected by JS
- Bug: Replace trailing slash of WOPI URL
- Bug: Try opening readonly documents too
- Bug: Fix revision history
- Feature: Add rtf and txt as supported file formats
- Feature: Add icon to admin page sidebar
- Feature: Add logging and template to unhandled exceptions

## 1.1.25
- Bug: Fix height for revision history viewer
- Feature: Support for multitenancy installations of LibreOffice Online

## 1.1.24
- Bug: Fix undefined PHP notices
- Security: Properly check for password on password protected shares
