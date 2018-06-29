package com.entity;


import java.util.ArrayList;
import java.util.List;


public class ShoppingCart {

    private int userid;
    private List<ShoppingCartItem> shoppingCartItems = new ArrayList<ShoppingCartItem>();

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public List<ShoppingCartItem> getShoppingCartItems() {
        return shoppingCartItems;
    }

    public void setShoppingCartItems(List<ShoppingCartItem> shoppingCartItems) {
        this.shoppingCartItems = shoppingCartItems;
    }
}
