<%@ Page Title="" Language="C#" MasterPageFile="~/MovieTickeBooking.master" AutoEventWireup="true" CodeFile="AboutUs.aspx.cs" Inherits="AboutUs" %>




<asp:Content ID="cnt1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     
    <div style="border-style: inherit; font-size: 20px; color: #FFFF00; background-color: #000000; font-family: 'Times New Roman', Times, serif; text-align: center;">
		<h2 > About Us </h2>
	</div>


    <div style="padding-top: 60px">
         <div>
            <img src="Images/look.jpg" width="40%"  alt="" height="auto">
         </div>
          
         <div style="padding-top: 3px">
            <h2 style="font-family:'Baskerville Old Face';font-style:italic;text-shadow:2px 1px 2px deepskyblue">Super Cinema one of the best cinema exhibition.</h2>
<p style="font-family:'Times New Roman';font-weight:bold;font-style:italic">
           Super Cinema is one of the best cinema of jamnagar city has been started since <strong>2013</strong> by <strong>Chirag  Savaliya</strong>
    and <strong>Parth Dattani</strong>.Super Cinema is a single screen cinema hall having <strong>50</strong> total number of seats.
    Super Cinema provides <strong>4</strong> movie shows in a day.There are <strong>three</strong> different class of movie tickets are there in Super Cinema namely <strong>Platinum , Golden , Silver</strong>.Super Cinema provides
    facility of <strong>E-Ticket Booking</strong> to the customers to book tickets for cinema hall from anywhere and anytime instead of going ticket counter of cinema hall.This facility save time and mony of customers. 
    Customers can book one or more than one tickets having different ticket class in a single ticket and can download their ticket in form of pdf.
</p>
            
   </div>
  </div>
   <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/happy-customers.png" ImageAlign="Middle"/>
</asp:Content>
