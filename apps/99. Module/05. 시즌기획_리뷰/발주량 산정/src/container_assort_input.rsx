<Container
  id="container_assort_input"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="0"
  showBody={true}
  showBorder={false}
  style={{ ordered: [{ background: "canvas" }] }}
>
  <Header>
    <Text
      id="containerTitle26"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="73be6" viewKey="View 1">
    <NumberInput
      id="size_7_qty"
      currency="USD"
      disabled={
        '{{ md_assort_control.selectedItem.value == "percent" ? true : false }}'
      }
      inputValue={0}
      label={'{{ var_selected_size_info.value.size_nm_list[6] || "-" }} '}
      labelPosition="top"
      margin="4px 4px 4px 0"
      placeholder="Enter value"
      showSeparators={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort.size_7.qty }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_per"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_2_qty"
      currency="USD"
      disabled={
        '{{ md_assort_control.selectedItem.value == "percent" ? true : false }}'
      }
      inputValue={0}
      label={'{{ var_selected_size_info.value.size_nm_list[1] || "-" }} '}
      labelPosition="top"
      margin="4px 4px 4px 0"
      placeholder="Enter value"
      showSeparators={true}
      style={{ ordered: [] }}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort.size_2.qty }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_per"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_8_qty"
      currency="USD"
      disabled={
        '{{ md_assort_control.selectedItem.value == "percent" ? true : false }}'
      }
      inputValue={0}
      label={'{{ var_selected_size_info.value.size_nm_list[7] || "-" }} '}
      labelPosition="top"
      margin="4px 4px 4px 0"
      placeholder="Enter value"
      showSeparators={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort?.size_8?.qty || 0 }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_per"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_9_qty"
      currency="USD"
      disabled={
        '{{ md_assort_control.selectedItem.value == "percent" ? true : false }}'
      }
      inputValue={0}
      label={'{{ var_selected_size_info.value.size_nm_list[8] || "-" }} '}
      labelPosition="top"
      margin="4px 4px 4px 0"
      placeholder="Enter value"
      showSeparators={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort?.size_9?.qty || 0}}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_per"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_10_qty"
      currency="USD"
      disabled={
        '{{ md_assort_control.selectedItem.value == "percent" ? true : false }}'
      }
      inputValue={0}
      label={'{{ var_selected_size_info.value.size_nm_list[9] || "-" }} '}
      labelPosition="top"
      margin="4px 4px 4px 0"
      placeholder="Enter value"
      showSeparators={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort?.size_10?.qty || 0 }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_per"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_1_qty"
      currency="USD"
      disabled={
        '{{ md_assort_control.selectedItem.value == "percent" ? true : false }}'
      }
      inputValue={0}
      label={'{{ var_selected_size_info.value.size_nm_list[0] || "-" }} '}
      labelPosition="top"
      margin="4px 4px 4px 0"
      placeholder="Enter value"
      showSeparators={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort.size_1.qty }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_per"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_4_qty"
      currency="USD"
      disabled={
        '{{ md_assort_control.selectedItem.value == "percent" ? true : false }}'
      }
      inputValue={0}
      label={'{{ var_selected_size_info.value.size_nm_list[3] || "-" }} '}
      labelPosition="top"
      margin="4px 4px 4px 0"
      placeholder="Enter value"
      showSeparators={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort.size_4.qty }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_per"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_3_qty"
      currency="USD"
      disabled={
        '{{ md_assort_control.selectedItem.value == "percent" ? true : false }}'
      }
      inputValue={0}
      label={'{{ var_selected_size_info.value.size_nm_list[2] || "-" }} '}
      labelPosition="top"
      margin="4px 4px 4px 0"
      placeholder="Enter value"
      showSeparators={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort.size_3.qty }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_per"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_5_qty"
      currency="USD"
      disabled={
        '{{ md_assort_control.selectedItem.value == "percent" ? true : false }}'
      }
      inputValue={0}
      label={'{{ var_selected_size_info.value.size_nm_list[4] || "-" }} '}
      labelPosition="top"
      margin="4px 4px 4px 0"
      placeholder="Enter value"
      showSeparators={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort.size_5.qty }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_per"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_6_qty"
      currency="USD"
      disabled={
        '{{ md_assort_control.selectedItem.value == "percent" ? true : false }}'
      }
      inputValue={0}
      label={'{{ var_selected_size_info.value.size_nm_list[5] || "-" }} '}
      labelPosition="top"
      margin="4px 4px 4px 0"
      placeholder="Enter value"
      showSeparators={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort.size_6.qty }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_per"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_1_per"
      currency="USD"
      decimalPlaces="0"
      disabled={
        '{{ md_assort_control.selectedItem.value == "qty" ? true : false }}'
      }
      format="percent"
      inputValue={0}
      label=""
      labelPosition="top"
      margin="4px 4px 4px 0"
      max={1}
      min={0}
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? '' : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort.size_1.per }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_qty"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_7_per"
      currency="USD"
      decimalPlaces="0"
      disabled={
        '{{ md_assort_control.selectedItem.value == "qty" ? true : false }}'
      }
      format="percent"
      inputValue={0}
      label=""
      labelPosition="top"
      margin="4px 4px 4px 0"
      max={1}
      min={0}
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort.size_7.per  }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_qty"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_8_per"
      currency="USD"
      decimalPlaces="0"
      disabled={
        '{{ md_assort_control.selectedItem.value == "qty" ? true : false }}'
      }
      format="percent"
      inputValue={0}
      label=""
      labelPosition="top"
      margin="4px 4px 4px 0"
      max={1}
      min={0}
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort?.size_8?.per || 0 }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_qty"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_9_per"
      currency="USD"
      decimalPlaces="0"
      disabled={
        '{{ md_assort_control.selectedItem.value == "qty" ? true : false }}'
      }
      format="percent"
      inputValue={0}
      label=""
      labelPosition="top"
      margin="4px 4px 4px 0"
      max={1}
      min={0}
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort?.size_9?.per || 0 }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_qty"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_10_per"
      currency="USD"
      decimalPlaces="0"
      disabled={
        '{{ md_assort_control.selectedItem.value == "qty" ? true : false }}'
      }
      format="percent"
      inputValue={0}
      label=""
      labelPosition="top"
      margin="4px 4px 4px 0"
      max={1}
      min={0}
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort?.size_10?.per || 0 }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_qty"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_2_per"
      currency="USD"
      decimalPlaces="0"
      disabled={
        '{{ md_assort_control.selectedItem.value == "qty" ? true : false }}'
      }
      format="percent"
      inputValue={0}
      label=""
      labelPosition="top"
      margin="4px 4px 4px 0"
      max={1}
      min={0}
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort.size_2.per  }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_qty"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_3_per"
      currency="USD"
      decimalPlaces="0"
      disabled={
        '{{ md_assort_control.selectedItem.value == "qty" ? true : false }}'
      }
      format="percent"
      inputValue={0}
      label=""
      labelPosition="top"
      margin="4px 4px 4px 0"
      max={1}
      min={0}
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort.size_3.per  }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_qty"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_4_per"
      currency="USD"
      decimalPlaces="0"
      disabled={
        '{{ md_assort_control.selectedItem.value == "qty" ? true : false }}'
      }
      format="percent"
      inputValue={0}
      label=""
      labelPosition="top"
      margin="4px 4px 4px 0"
      max={1}
      min={0}
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort.size_4.per  }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_qty"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_5_per"
      currency="USD"
      decimalPlaces="0"
      disabled={
        '{{ md_assort_control.selectedItem.value == "qty" ? true : false }}'
      }
      format="percent"
      inputValue={0}
      label=""
      labelPosition="top"
      margin="4px 4px 4px 0"
      max={1}
      min={0}
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort.size_5.per  }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_qty"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="size_6_per"
      currency="USD"
      decimalPlaces="0"
      disabled={
        '{{ md_assort_control.selectedItem.value == "qty" ? true : false }}'
      }
      format="percent"
      inputValue={0}
      label=""
      labelPosition="top"
      margin="4px 4px 4px 0"
      max={1}
      min={0}
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].assort.size_6.per  }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_qty"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <SegmentedControl
      id="md_assort_control"
      itemMode="static"
      label=""
      labelPosition="top"
      paddingType="spacious"
      value="{{ self.values[0] }}"
    >
      <Option id="f51b4" label="비율" value="percent" />
      <Option id="2d403" label="수량" value="qty" />
    </SegmentedControl>
    <Button
      id="button1"
      iconBefore="bold/computer-storage-floppy-disk"
      style={{ ordered: [{ background: "primary" }] }}
      text="저장하기"
    >
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="save_assort"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="save_assort_final"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </View>
</Container>
