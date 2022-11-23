
# CatGIFApp
CatGIFApp-iOS-code-test 

<img src="https://user-images.githubusercontent.com/28348787/203441428-bbb55ee9-ad49-42be-8dc2-b0869fe64fa6.png" width="500">

### Solution

Starting with the UI, I loosely followed a MVVM approach. This provides a reasonably fast solution compared to something like VIPER but still allows a decent adherence to SOLID principals for testability of critical UI logic. 

For displaying a GIF I found standard iOS frameworks lacked support, through research I learned there was some complexity to memory efficiency in custom solutions and decided an already established third party solution would be a good fit.

I then added some tests for the view models pagination and error logic.

With the UI in place, I had a good understanding of what data was required and turned to the networking layer, I looked through TheCataAPI docs and tested some calls with postman. Once I was happy with the responses, I modelled a basic networking layer that would match the postman requests. I tried to keep this simple but still separated out logic I thought was worth testing. 

To finish off the App, the networking and UI layers were brought together via composition, utilising adapters, factories and mapping logic to provide flexibility and maintainability. 
