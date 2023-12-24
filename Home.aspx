<%@ Page Title="" Language="C#" MasterPageFile="~/MovieTickeBooking.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
    <div>
        <marquee behavior="alternate"><h2 style="font-family:'Baskerville Old Face';font-style:italic;color:blue;text-shadow:2px 1px 2px lime">Welcome To Super Cinema.</h2></marquee>
    </div>
        <table border="0" align="center" width="100%" cellspacing="10" style="background-color:lightpink">
            <tr>
                <td>
                    <asp:Image ID="i1" runat="server" ImageUrl="~/Images/sg.jpg" BorderStyle="Double" Width="100%" Height="220" />
                </td>
                <td>
                    <asp:Image ID="i2" runat="server" ImageUrl="~/Images/smax.jpg" BorderStyle="Double" Width="100%" Height="220" />
                </td>
                <td>
                    <asp:Image ID="i3" runat="server" ImageUrl="~/Images/fm.jpg" BorderStyle="Double" Width="100%" Height="220" />
                </td>
            </tr>
        </table>

        <table border="0" align="center" width="100%" cellspacing="10" style="background-color:lightpink">
            <tr>
                <td width="30%">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/sony.jpg" BorderStyle="Double" Width="100%" Height="220" />
                </td>
                <td width="30%">
                    <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/sm.jpg" BorderStyle="Double" Width="100%" Height="220" />
                </td width="40%">
                <td>
                    <asp:Image ID="Image3" runat="server" ImageUrl="~/Images/mo.jpg" BorderStyle="Double" Width="100%" Height="220" />
                </td>
            </tr>
        </table>
</asp:Content>
