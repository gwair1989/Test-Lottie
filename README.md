# Test-Lottie
iOS Implementation - Verbose app start on loading delays

This adds verbose communication to the loading screen if and when a server isn't responding as expected or otherwise the loading process is slower than what one would deam as acceptable normal behaviour. 

 

UX Flow is described here:

Conditions of satisfaction:

 * If one of the requests in the app start loading process fails to return a result (fail or data) within a stipulated time tolerance. (The actual time tolerance is to-be-decided)

 * When in verbose mode, a sequence of copy text messages should be shown to the user, explaining in human terms that work we are working on it, for as long as it takes to complete the entire loading process, or an error occurs (such as a timeout).

 * In verbose mode the loader sequence should display each text message to 2-3 seconds before displaying the next.

 *(PHRASEAPP) Text messages should be read in local languages from Phraseapp.

 * Enough messages should be supported to be able to show message at the above pace for as long as it is likely to take before a network timeout occurs, ie 5.

* (NOT VALID ANYMORE) -For the case where a problem occurs before, or while fetching Phraseapp strings, the app should bundle English messages within the app as fallback.-

* (PHRASEAPP) For the case wirer a problem occurs before, or while fetching Praseapp strings, no messages are shown.

