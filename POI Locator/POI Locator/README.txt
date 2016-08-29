Installing: Install the podfiles needed for this project (GoogleMaps, GooglePlacePicker, SwiftyJson)
After installing make sure that under the POI Locator project file under General -> Linked Framework and Librariers should be an entry for swifty json
If SwiftyJson is not recognized, clean and build will help.

Usage: On the first start the user see an MapViewController with google maps. With clicking on the filter button the user can switch on or off locations he/she wants to search for. The Categories are stored on the phone memory, also the current location. It is also possible that the user can go to his/her actual position if gps is allowed. User can also search with an nice autocomplete function for addresses

Hitting the refresh button will search for places selected by the users categories.
When a user clicks on an  icon, an detail presentation is shown, with flickr images around the selected locations. Clicking the refresh button will load new flickr images if available for the certain location.

By clicking on the bookmark icon the place is saved in the persistent storage. Under the bookmark icon on the TabBarController the users can see all the bookmarked places. Deleting an bookmarked place is also possible.