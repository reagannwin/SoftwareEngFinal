import 'package:flutter/material.dart';

class Book {
  String title = "no data";
  String description = "no data";
  String author = "no data";
  String edition = "no data";
  String published = "no data";
  String rating = "no data";
  String reviewCount = "no data";
  String price = "no data";
  String topRated = "no data";
  String bestSeller = "no data";
  String isbn10 = "no data";
  String isbn13 = "no data";
  bool isFavorite = false;

  Book();

  void populateBook(List<dynamic> data) {
    int listLength = data.length;
    int index = 0;
    while(index < listLength) {
      switch(index) {
        case 0:
          title = data[index].toString();
          break;
        case 1:
          description = data[index].toString();
          break;
        case 2:
          author = data[index].toString();
          break;
        case 3:
          isbn10 = data[index].toString();
          break;
        case 4:
          isbn13 = data[index].toString();
          break;
        case 5:
          published = data[index].toString();
          break;
        case 6:
          edition = data[index].toString();
          break;
        case 7:
          bestSeller = data[index].toString();
          break;
        case 8:
          topRated = data[index].toString();
          break;
        case 9:
          rating = data[index].toString();
          break;
        case 10:
          reviewCount = data[index].toString();
          break;
        case 11:
          price = data[index].toString();
          break;
        default:
          print("=== populateBook: Critical Error! ===");
          break;
      }
      index++;
    }

  }

  String getTitle() {
    return title;
  }

  void setTitle(String newTitle) {
    title = newTitle;
  }

  String getDescription() {
    return description;
  }

  void setDescription(String newDescription) {
    description = newDescription;
  }

  String getAuthor() {
    return author;
  }

  void setAuthor(String newAuthor) {
    author = newAuthor;
  }

  String getISBN10() {
    return isbn10;
  }

  void setISBN10(String newISBN10) {
    isbn10 = newISBN10;
  }

  String getISBN13() {
    return isbn13;
  }

  void setISBN13(String newISBN13) {
    isbn13 = newISBN13;
  }

  String getPublishDate() {
    return published;
  }

  void setPublishDate(String newPublishDate) {
    published = newPublishDate;
  }

  String getEdition() {
    return edition;
  }

  void setEdition(String newEdition) {
    edition = newEdition;
  }

  String getBestSeller() {
    return bestSeller;
  }

  void setBestSeller(String newBestSeller) {
    bestSeller = newBestSeller;
  }

  String getTopRated() {
    return topRated;
  }

  void setTopRated(String newTopRated) {
    topRated = newTopRated;
  }

  String getRating() {
    return rating;
  }

  void setRating(String newRating) {
    rating = newRating;
  }

  String getReviewCount() {
    return reviewCount;
  }

  void setReviewCount(String newReviewCount) {
    reviewCount = newReviewCount;
  }

  String getPrice() {
    return price;
  }

  void setPrice(String newPrice) {
    price = newPrice;
  }

  void setFavoriteStatus(bool update) {
    isFavorite = update;
  }

  void printBookData() {
    print(" ======== Book Data: ========");
    print(title);
    print(description);
    print(author);
    print(edition);
    print(published);
    print(rating);
    print(reviewCount);
    print(price);
    print(bestSeller);
    print(topRated);
    print(isbn10);
    print(isbn13);
    print("========== END ==========");
  }
}