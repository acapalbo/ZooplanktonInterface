# ZooplanktonInterface

## Graphical Interface for Zooplankton Segmentation and Classification algorithm. Most up to date release is v0.7.3-prerelease, it can be found in the releases/tags tab.

## [Link to Associated Paper](https://www.mdpi.com/1424-8220/26/6/1824)

## Note: Repository is in rough shape, currently working to reorganize and bring everything up to standard. Please post in the issues tab or contact me directly if there is something specific you'd like done. Thank you!

## Contact Email: acapalbo@fau.edu

### Version Notes
_____________
#### v0.7.3-prerelease:
* 2023a users should have no issues relating to start/end slider
* Added iterative output folder as well as dialog box to choose output destination
* Added 'validate' option in Segmentation tab to show images with segmented bounding boxes
* Added edit fields for hyperparameters
#### v0.7.2-prerelease:
* Added 2 more models, GoogLeNet and DarkNet
* Included iterative model saving to prevent overwriting models after multiple runs
* Increased max epochs to 100
* note: 2023a users will experience errors due to range sliders not being implemented until 2023b
#### v0.7.1-prerelease:
* fixed transition from segmentation tab to classification
* note: 2023 users may experience errors when training/classifying, some functions currently not cross compatible
#### v0.6.1-prerelease
* partially patched issue that sends app to back of window stack (alwaysontop)
* added error/confirmation messages to some fields
* added "Save small images" and min length/width fields for segmentation panel
* fixed button and label issue when moving from pre-processing to segmentation
#### v0.5.5-prerelease
* finally functioning *mostly* as intended
* some issues carrying video across all panels, works from pre-processing to segmentation but crashes on segmentation to classification
* individual panel usage seems to be functioning as expected
#### v0.5.3-prerelease - v0.5.4-prerelease
* trying to fix app dependencies, namely simulink model
* **note: non-functioning version**
#### v0.5.2-prerelease
* fixed "Prepare Dataset", plot shows class identifiers
* **note: non-functioning version**
#### v0.5.1-prerelease
* added some error messages
* fixed issues with loading image bars
* **note: non-functioning version**

