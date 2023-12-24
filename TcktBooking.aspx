<%@ Page Title="" Language="C#" MasterPageFile="~/MovieTickeBooking.master" AutoEventWireup="true" CodeFile="TcktBooking.aspx.cs" Inherits="TcktBooking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
        var Rslt = false;
        function ValidateTcktRts()
        {
            if (document.getElementById("txtTcktQunPltnm").value.length < 1 && document.getElementById("txtTcktQunGoldn").value.length < 1 && document.getElementById("txtTcktQunSlvr").value.length < 1)
            {
                document.getElementById("lblErrorTcktBook").innerHTML = "A Quentity Of At Least 1 Kind Of Ticket Must Be Required.";
            }
            else if (!DigitValidation(document.getElementById("txtTcktQunPltnm").value))
            {
                document.getElementById("lblErrorTcktBook").innerHTML = "Enter Valid Quentity Of Platinum Ticket.It Must Be In Number (Digits).";
            }
            else if (!DigitValidation(document.getElementById("txtTcktQunGoldn").value)) {
                document.getElementById("lblErrorTcktBook").innerHTML = "Enter Valid Quentity Of Golden Ticket.It Must Be In Number (Digits).";
            }
            else if (!DigitValidation(document.getElementById("txtTcktQunSlvr").value))
            {
                document.getElementById("lblErrorTcktBook").innerHTML = "Enter Valid Quentity Of Silver Ticket.It Must Be In Number (Digits).";
            }
            else if(parseInt(document.getElementById("txtTcktQunPltnm").value)>parseInt(document.getElementById("txtPltnmAvlblSts").value))
            {
                if (parseInt(document.getElementById("txtPltnmAvlblSts").value) == 0)
                {
                    document.getElementById("lblErrorTcktBook").innerHTML = "Platinum Seats Not Available.";
                }
                else
                {
                    document.getElementById("lblErrorTcktBook").innerHTML = "Enter Valid Quentity Of Platinum Seats.It Must Be Less Than Or Equal To Platinum Available Seats.";
                }
            }
            else if (parseInt(document.getElementById("txtTcktQunGoldn").value) > parseInt(document.getElementById("txtGldnAvlblSts").value))
            {
                if (parseInt(document.getElementById("txtGldnAvlblSts").value)==0)
                {
                    document.getElementById("lblErrorTcktBook").innerHTML = "Golden Seats Not Available.";
                }
                else
                {
                    document.getElementById("lblErrorTcktBook").innerHTML = "Enter Valid Quentity Of Golden Seats.It Must Be Less Than Or Equal To Golden Available Seats.";
                }
            }
            else if (parseInt(document.getElementById("txtTcktQunSlvr").value) > parseInt(document.getElementById("txtSlvrAvlblSts").value))
            {
                if (parseInt(document.getElementById("txtSlvrAvlblSts").value)==0)
                {
                    document.getElementById("lblErrorTcktBook").innerHTML = "Silver Seats Not Available.";
                }
                else
                {
                    document.getElementById("lblErrorTcktBook").innerHTML = "Enter Valid Quentity Of Silver.It Must Be Less Than Or Equal To Silver Available Seats.";
                }
            }
            else if((parseInt(document.getElementById("txtTcktQunPltnm").value)<1) && (parseInt(document.getElementById("txtTcktQunGoldn").value)<1) && (parseInt(document.getElementById("txtTcktQunSlvr").value)<1))
            {
                document.getElementById("lblErrorTcktBook").innerHTML = "A quantity Of At Least One Kind Must Be Greater Than Or Equal To 1.";
            }
            //else if (parseInt(document.getElementById("txtPltnmAvlblSts").value)<1)
            //{
            //    if (parseInt(document.getElementById("txtTcktQunPltnm").value) > 0)
            //    {
            //        document.getElementById("lblErrorTcktBook").innerHTML = "Platinum Seats Not Available.";
            //    }
            //}
            //else if (parseInt(document.getElementById("txtGldnAvlblSts").value) < 1)
            //{
            //    if (parseInt(document.getElementById("txtTcktQunGoldn").value) > 0)
            //    {
            //        document.getElementById("lblErrorTcktBook").innerHTML = "Golden Seats Not Available.";
            //    }
            //}
            //else if (parseInt(document.getElementById("txtSlvrAvlblSts").value) < 1)
            //{
            //    if (parseInt(document.getElementById("txtTcktQunSlvr").value) > 0)
            //    {
            //        document.getElementById("lblErrorTcktBook").innerHTML = "Silver Seats Not Available.";
            //    }
            //}
            else
            {
            
                Rslt = true;
            }
            return Rslt;
        }

    </script>
    <table border="0" class="Tbl-Outer">
          <tr>
            <td align="center" colspan="3">
             <asp:Image ID="imgMvBnrTcktBook" runat="server" ImageUrl="~/Lighthouse.jpg" Width="20%" Height="310"></asp:Image>
            </td>
         </tr>

        <tr>
            <td align="center" colspan="3">
             <asp:Label ID="lblMvNmTcktBook" runat="server" Font-Bold="true" ForeColor="Green" Font-Italic="true"></asp:Label>
            </td>
         </tr>

        <tr>
              <td colspan="3" align="center">
                <table>
                    <tr>
                        <td class="Lbl-Inst">
                             Note : All Fields With
                        </td>
                        <td>
                             <p style="color:red">*</p>
                        </td>
                        <td class="Lbl-Inst">
                            Are Required.
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3" align="center">
                <asp:Label ID="lblErrorTcktBook" runat="server" CssClass="Lbl-Error" ClientIDMode="Static" />
            </td>
        </tr>
         <tr>
            <td width="45%" align="center">
                <table>
                    <tr>
                        <td>
                            <p style="color:red">*</p>
                        </td>
                        <td>
                            <p class="Lbl-Msg">Date</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="left">
                <table>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtdtTcktBook" runat="server" ReadOnly="true"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="btnClndrTcktBook" runat="server" Text="..." CssClass="Btn" OnClick="btnClndrTcktBook_Click"/>
                        </td>
                        <td>
                            <asp:Calendar ID="clndrTcktBook" runat="server" BackColor="White" BorderColor="Black" BorderStyle="Solid" CellSpacing="1" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="100px" NextPrevFormat="ShortMonth" Width="50%" Visible="false" OnSelectionChanged="clndrTcktBook_SelectionChanged">
                                <DayHeaderStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" Height="8pt" />
                                <DayStyle BackColor="#CCCCCC" />
                                <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="White" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                                <TitleStyle BackColor="#333399" BorderStyle="Solid" Font-Bold="True" Font-Size="12pt" ForeColor="White" Height="12pt" />
                                <TodayDayStyle BackColor="#999999" ForeColor="White" />
                            </asp:Calendar>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width="45%" align="center">
                <table>
                    <tr>
                        <td>
                            <p style="color:red">*</p>
                        </td>
                        <td>
                            <p class="Lbl-Msg">Select Show</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="left">
                <table>
                    <tr>
                        <td>
                           <asp:DropDownList ID="ddlShowTcktBook" runat="server" OnSelectedIndexChanged="ddlShowTcktBook_SelectedIndexChanged" AutoPostBack="true">
                             <asp:ListItem Text="-- Select Show --"></asp:ListItem>
                           </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="lblShowTime" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
         </tr>
       </table>
       <asp:Panel ID="pnlTcktBook" runat="server" Visible="false">
         <table border="0" class="Tbl-Outer">
           <tr>
            <td width="45%" align="center">
                <table>
                    <tr>
                        <td>
                            <p style="color:white">*</p>
                        </td>
                        <td>
                            <p class="Lbl-Msg">Available Seats</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="left">
                <table>
                    <tr style="font-weight:bold">
                        <td>
                            P
                        </td>
                        <td>
                            <asp:TextBox ID="txtPltnmAvlblSts" runat="server" Width="25%" ReadOnly="true" ClientIDMode="Static"></asp:TextBox>
                        </td>
                        <td>
                           G
                        </td>
                        <td>
                            <asp:TextBox ID="txtGldnAvlblSts" runat="server" Width="25%" ReadOnly="true" ClientIDMode="Static"></asp:TextBox>
                        </td>
                        <td>
                           S
                        </td>
                        <td>
                            <asp:TextBox ID="txtSlvrAvlblSts" runat="server" Width="25%" ReadOnly="true" ClientIDMode="Static"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr>
            <td width="45%" align="center">
                <table>
                    <tr>
                        <td>
                            <p style="color:white">*</p>
                        </td>
                        <td>
                            <p class="Lbl-Msg">Ticket Rates</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="left">
                <table>
                    <tr style="font-weight:bold">
                        <td>
                            P
                        </td>
                        <td>
                            <asp:TextBox ID="txtPltnmRt" runat="server" Width="25%" ReadOnly="true"></asp:TextBox>
                        </td>
                        <td>
                           G
                        </td>
                        <td>
                            <asp:TextBox ID="txtGoldnRt" runat="server" Width="25%" ReadOnly="true"></asp:TextBox>
                        </td>
                        <td>
                           S
                        </td>
                        <td>
                            <asp:TextBox ID="txtSlvrRt" runat="server" Width="25%" ReadOnly="true"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

          <tr>
            <td width="45%" align="center">
                <table>
                    <tr>
                        <td>
                            <p style="color:red">*</p>
                        </td>
                        <td>
                            <p class="Lbl-Msg">Ticket Quantity</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="left">
                <table>
                    <tr style="font-weight:bold">
                        <td>
                            P
                        </td>
                        <td>
                            <asp:TextBox ID="txtTcktQunPltnm" runat="server" Width="25%" Text="0" MaxLength="2" ClientIDMode="Static"></asp:TextBox>
                        </td>
                        <td>
                           G
                        </td>
                        <td>
                            <asp:TextBox ID="txtTcktQunGoldn" runat="server" Width="25%" Text="0" MaxLength="2" ClientIDMode="Static"></asp:TextBox>
                        </td>
                        <td>
                           S
                        </td>
                        <td>
                            <asp:TextBox ID="txtTcktQunSlvr" runat="server" Width="25%" Text="0" MaxLength="2" ClientIDMode="Static"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
           <td align="center" colspan="3">
            <asp:Button ID="btnNxt" runat="server" Text="NEXT" Width="10%" CssClass="Btn" OnClientClick="return ValidateTcktRts()" OnClick="btnNxt_Click" />
           </td>
        </tr>
     </table>
   </asp:Panel>
   <asp:Panel ID="pnlTcktBookInfo" runat="server" Visible="false">
        <table>
           <tr>
             <td>Platinum Tickets</td>
             <td>:</td>
             <td><asp:Label ID="lblTcktBookInfoP" runat="server" ClientIDMode="Static"></asp:Label></td>
           </tr>
           <tr>
             <td>Golden Tickets</td>
             <td>:</td>
             <td><asp:Label ID="lblTcktBookInfoG" runat="server" ClientIDMode="Static"></asp:Label></td>
           </tr>
           <tr>
             <td>Silver Tickets </td>
             <td>:</td>
             <td><asp:Label ID="lblTcktBookInfoS" runat="server" ClientIDMode="Static"></asp:Label></td>
           </tr>
            <tr>
             <td>Total Amount</td>
             <td>:</td>
             <td align="center">
             <asp:Label ID="lblTtlAmntTcktBook" runat="server" ClientIDMode="Static"></asp:Label>
             </td>
            </tr>
            <tr>
            <td align="center" colspan="3">
                <asp:Button ID="btnBook" runat="server" Text="BOOK" Width="50%" CssClass="Btn" OnClick="btnBook_Click" />
            </td>
        </tr>
          </table>
      </asp:Panel>
    <table width="100%">
        <tr>
            <td align="center">
                <asp:Button ID="btnCnclTcktBook" runat="server" Text="CANCEL" Width="11%" CssClass="Btn" OnClick="btnCnclTcktBook_Click" />
            </td>
        </tr>
    </table>
     <asp:GridView ID="dtGrdTcktInfo" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" Visible="False" OnRowDeleting="dtGrdTcktInfo_RowDeleting">
                <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="tcktBkId" HeaderText="Ticket Booking Id" ReadOnly="True">
                        <ControlStyle Width="10%" />
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mvId" HeaderText="Movie Id">
                        <ControlStyle Width="10%" />
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle Width="10%" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mvName" HeaderText="Movie Name">
                        <ControlStyle Width="10%" />
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle Width="10%" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="showName" HeaderText="Show Name">
                        <ControlStyle Width="12%" />
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle Width="12%" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="showTime" HeaderText="Show Time">
                        <ControlStyle Width="12%" />
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="12%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="tcktUseDt" HeaderText="Date">
                        <ControlStyle Width="12%" />
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="12%" />
                        </asp:BoundField>
                        <asp:CommandField ButtonType="Button" HeaderText="Download Ticket" ShowDeleteButton="True" DeleteText="Download">
                        <ControlStyle Width="25%" />
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="25%" />
                        </asp:CommandField>
                    </Columns>
                    <EditRowStyle BackColor="#7C6F57" />
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#E3EAEB" />
                    <SelectedRowStyle BackColor="#CC3300" Font-Bold="True" ForeColor="#FFFF99" />
                    <SortedAscendingCellStyle BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" />
                    <SortedDescendingCellStyle BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" />
    </asp:GridView>
</asp:Content>

