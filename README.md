# WxAlert

WxAlert, iOS application (app), aims to provide notifications for weather events based on app settings selected by the user. Current user interface, which is currently under development, shows daytime weather forecast for Reno, Nevada on Feb 14, 2019. It includes the sky condition, windspeed and direction, high and low temperatures, date, and a placeholder winter storm warning symbol.

<p align="center">
  <img src="/images/reno_Feb14.png" alt="Reno, NV weather." /> 
</p>

The upper row shows weather alerts as posted by the National Weather Service. Icons are shown for:
* Winter Weather Advisory
* Winter Storm Warning
* Special Weather Statement
* Flood Advisory
* Avalanche Warning
* High Wind Warning

The user interface is driven by a tab bar controller. Three tabs are available to the user. Search tab, Weather tab, and a Notifications setting tab. The UI scheme is presented below.

<p align="center">
  <img src="/images/WxAlertViews.png" alt="WxAlert tabBar views." /> 
</p>


## UI Interaction Diagram

After installation of the app, the user is first presented with Search tab. Both Weather tab and Notification settings tab are disabled. The user has to first search for a city for which to fetch the weather. Searching for a city is performed on an embedded SQLite database. This local database contains approximately 29,000 U.S. cities. Automatically obtaining the user's current location is not implemented at this time. This feature will be added as the development of the app progresses.

 <p align="center">
  <img src="/images/StateDiagram.png" alt="UI interaction diagram." /> 
</p>

Once the desired city is selected, the user is able to view the weather forecast for that city. In addition, specific weather alert notifications can be made in the settings tab. The specific notifications that can be selected are:

["Fire danger", "Fog", "Flood", "Freeze", "Hail", "High Winds", "Ice", "Rain", "Sleet", "Snow", "Thunderstorm", "Tornado"]