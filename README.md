**Bus Seat Layout App - README**

**Project Overview**

This Flutter application demonstrates the implementation of a bus seat layout system based on specific requirements provided by the company. The app fetches bus layout data from two different JSON APIs and renders the layout dynamically with support for various element types (seats, doors, driver area, and spaces).

**📱 Screenshots**

API 1 Layout

![1000063571](https://github.com/user-attachments/assets/263521e6-dce0-4577-95dd-77fb6f9db907)

API 2 Layout

![1000063572](https://github.com/user-attachments/assets/66e790dc-c384-44ee-8161-41207d8cebd5)


📥 APK Download

[Download Latest Release APK](https://drive.google.com/file/d/1Hu3sDHCLBQO-JOgo544U0nBpzNzAhhBv/view?usp=sharing)

**✅ Requirements Implementation**

**Core Requirements Met:**

✅ JSON API Integration

Fetches data from two provided API endpoints

API 1: https://api.jsonbin.io/v3/b/68bd5016ae596e708fe58eb1

API 2: https://api.jsonbin.io/v3/b/68b7cce7d0ea881f407010d6

✅ API Toggle Functionality

Implemented segmented control for switching between APIs

Real-time layout updates on API change

✅ Dynamic Layout Generation

Handles both array and map row formats from JSON

Calculates maximum columns dynamically

Renders mixed element types correctly

✅ Element Type Rendering

Seats: Boxes with seat names (A1, A2, B1, etc.)

Doors: Boxes with door icon and label

Driver: Box with driver icon and label

Spaces: Blank/empty areas

✅ State Management

Implemented BLoC pattern as requested

Proper state handling (Loading, Loaded, Error states)

✅ Clean Architecture

Separation of concerns (Data, Domain, Presentation layers)

Repository pattern implementation

Use cases for business logic

✅ Error Handling

User-friendly error messages

Network error handling

Data parsing error handling

Retry functionality

✅ Responsive Design

Works on various screen sizes

Adaptive layout using LayoutBuilder

Consistent UI across devices

