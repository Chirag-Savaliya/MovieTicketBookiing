<%@ Page Title="" Language="C#" MasterPageFile="~/MovieTickeBooking.master" AutoEventWireup="true" CodeFile="BnnrsMngmnt.aspx.cs" Inherits="BnnrsMngmnt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
    <table class="Tbl-Outer" border="0">
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
                <asp:Label ID="lblError" runat="server" CssClass="Lbl-Error" />
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
                            <p class="Lbl-Msg"> Select Image For Banner</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="center">
                <asp:FileUpload ID="flUpld" runat="server" />
            </td>
        </tr>
        <tr>
            <td colspan="3" align="center">
                <asp:Button ID="btnAdd" runat="server" CssClass="Btn" Text="ADD" Width="10%" OnClick="btnAdd_Click" />
            </td>
        </tr>
        <tr>
            <td colspan="3">
                  <asp:GridView ID="dtGrdBnnr" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" OnRowDeleting="dtGrdBnnr_RowDeleting" Visible="False">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate> 
                                <asp:CheckBox ID="chbxHdr" runat="server" Width="2%" OnCheckedChanged="chbxHdr_CheckedChanged" AutoPostBack="true" />
                            </HeaderTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chbxClmn" runat="server" AutoPostBack="true" OnCheckedChanged="chbxClmn_CheckedChanged" />
                            </ItemTemplate>
                            <ControlStyle Width="3%" />
                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="3%" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="bnrId" HeaderText="Banner Id" ReadOnly="True">
                        <ControlStyle Width="2%" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="2%" />
                        </asp:BoundField>
                        <asp:ImageField DataImageUrlField="bnrId" DataImageUrlFormatString="BnnrHndler.ashx?imgBnr={0}" HeaderText="Banner Image">
                            <ControlStyle Width="15%" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                        </asp:ImageField>
                        <asp:CommandField ButtonType="Button" HeaderText="Delete Banner" ShowDeleteButton="True">
                        <ControlStyle Width="15%" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
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
                </td>
        </tr>
        <tr>
            <td colspan="3" align="center">
                <asp:Button ID="btnDltAll" runat="server" Text="DELETE SELECTED ITEMS" CssClass="Btn" OnClick="btnDltAll_Click" Visible="False" />
            </td>
        </tr>
    </table>
</asp:Content>

