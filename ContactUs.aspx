<%@ Page Title="" Language="C#" MasterPageFile="~/MovieTickeBooking.master" AutoEventWireup="true" CodeFile="ContactUs.aspx.cs" Inherits="AboutUs" %>


<asp:Content ID="cnt1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div style="border-style: inherit; font-size: 20px; color: #FFFF00; background-color: #000000; font-family: 'Times New Roman', Times, serif; text-align: center;">
		<h2 > Contact Us </h2>
        
	</div>
    
    <table border="0" width="100%" align="left">
        <tr>
            <td align="center" width="100%" colspan="2">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3686.591296545483!2d70.05952256443238!3d22.481987841957487!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39576aa8807c6ecf%3A0xdc38c612891ec83!2sBhavan&#39;s%20Shree%20H.J%20Doshi%20Information%20Technology%20Institute!5e0!3m2!1sen!2sin!4v1581143314218!5m2!1sen!2sin" width="100%" height="450" frameborder="0" style="border:0;" allowfullscreen=""></iframe>
            </td>
        </tr>
        <tr>
            <td align="center" width="50%" colspan="2">
                <h1 style="font-family: 'times New Roman', Times, serif; color: #FF0000;">Team Members</h1>
            </td>
        </tr>
        <tr width="100%">
            <td align="center" width="50%">
                <asp:Image ID="Image8" runat="server" ImageUrl="~/Images/pd.jpg" Width="100%" />
            </td>
            <td align="center" width="50%">
                <asp:Image ID="Image9" runat="server" ImageUrl="~/Images/Chirag.jpg" Width="100%" Height="869"/>
            </td>
        </tr>
        <tr>
            <td align="center">
                <b>Name : Parth Dattani</b>
            </td>
            <td align="center">
                 <b>Name : Chirag Savaliya</b>
            </td>
        </tr>
        <tr>
            <td align="center">
                <b>Contact No : 0000000000</b>
            </td>
            <td align="center">
                 <b>Contact No : 1111111111</b>
            </td>
        </tr>
        <tr>
            <td align="center">
                <b>E-Mail : dattaniparth2@gmail.com</b>
            </td>
            <td align="center">
                 <b>E-Mail : chirag@gmail.com</b>
            </td>
        </tr>
    </table>
        <br />
   <table border="0" width="100%" style="background-color: #C0C0C0; font-family: 'Times New Roman', Times, serif;">
     
     
     <tr>
        <td width="30%" align="center" rowspan="2">
            <asp:Image ID="Image5" runat="server" ImageUrl="~/Images/Cinema-Wallpaper-Download-Free.jpg" Height="5%" Width="100%" />
        </td>

        <td width="10%" align="center">
         <h3><p style="font-family: 'Times New Roman', Times, serif"><b>Address </b></p></h3>
        </td>

        <td width="10%" align="center">
         <h3><p style="font-family: 'Times New Roman', Times, serif"><b>Contacts </b></p></h3>
        </td>
     </tr>

    <tr>
        <td width="15%" align="center" valign="top">
         <p style="font-family: 'Times New Roman', Times, serif">New Abc Road,Near HJD Park,Jamnagar-361110</p>
        </td>

        <td width="15%" align="center" valign="top">
         <p style="font-family: 'Times New Roman', Times, serif"><b>Email : &nbsp	<a href="">supercinema@gmail.com</a></b></p>
               <p style="font-family: 'Times New Roman', Times, serif"><b>Mobile No : &nbsp	(0288)0123456</b></p>
        </td>
     </tr>
   </table> 
      
</asp:Content>
