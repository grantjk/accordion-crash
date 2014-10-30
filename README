A really contrived example of the issue I'm currently facing. By calling `invalidateLayoutWithoutAnimation` during a `cellForItemAtIndexPath` call, the app crashes when eventually scrolling to dequeue the third section header.

Goal: To have an accordion like pattern where the cells collapse / expand when a button is tapped in the cells

Problem: Calling `invalidateLayout` to relayout the cells, triggers another call to `cellForItemAtIndexPath` where something in there is calling `invalidateLayout` again.

Result: The collection view's layout's layoutAttributes are set to `nil` resulting in an error when trying to dequeue a section header.

Notes:
- I have since fixed this issue in my production app.
- Issue occurs onnly on iOS7. Seems fixed on iOS8.
- Errors emitted from UICollectionView were not helpful.
- This is entirely my fault, but tracing down the code that's calling `invalidateLayout` has been tricky.
- I can't figure out how to set a symbolic breakpoint on `invalidateLayout`
