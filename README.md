# GeoBooth (Revamped Using UIKit and VIPER Architecture)
<img src='https://github.com/gregoriusyuristama/GeoBoothUIKit/assets/102383943/9a3e5baa-a460-40f5-897f-534a6e2280c1' width='150'>

> Capture, Filter, and Relive your Memorable Moments, Right where they happen

[![Swift Version][swift-image]][swift-url]

Do you ever wish you could relive some of your most memorable moments? Well, now you can! With our innovative technology, you can capture and filter your precious memories right where they happen. Imagine being able to look back on those special moments and feel like you are experiencing them all over again. It's like having a time machine at your fingertips! Whether you're at a family gathering, exploring a new place, or simply enjoying a beautiful sunset, our technology allows you to capture those moments and cherish them forever. So why wait? Start reliving your unforgettable memories today!

## Preview: 

<img src='https://github.com/gregoriusyuristama/GeoBoothUIKit/assets/102383943/99ecc7be-c6a0-4b7e-a434-e4145e0fc8a9' width='300'>
<img src='https://github.com/gregoriusyuristama/GeoBoothUIKit/assets/102383943/e23cb156-3547-4646-bdfc-a644ee243d22' width='300'>
<img src='https://github.com/gregoriusyuristama/GeoBoothUIKit/assets/102383943/36518767-cf37-4b42-9016-1e02f8c5291a' width='300'>
<img src='https://github.com/gregoriusyuristama/GeoBoothUIKit/assets/102383943/11bda68a-ff36-4925-81b5-60e9de6fae19' width='300'>

## Prerequisites
This project built using supabase and you need to create a db schema like this: 

<img src='https://github.com/gregoriusyuristama/GeoBoothUIKit/assets/102383943/a63edd8a-3064-4312-9310-bee9d8afcbb1' width='500'>

- Don't forget to set the RLS policy for each table
- Also create a bucket called `geobooth` for storing images
- Create Database Function for `add_album` and `update_album`

## Installation
1. Clone the repo 
```sh
git clone https://github.com/gregoriusyuristama/GeoBoothUIKit.git
```
2. Create `Supabase-Secret.plist` file on `GeoboothUIKit/Core/Utilities/Supabase` plist file should contain you `SUPABASE_URL` and `SUPABASE_API_KEY`
3. Run the project

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
