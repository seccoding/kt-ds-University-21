package com.ktdsuniversity.edu.naver.mv.util.db;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public final class AutoMapper {

	public static <T> T makeAllRowDatas(ResultSet rs, T valueObject, Class<? extends Object> cls) {
		if (valueObject == null) {
			valueObject = (T) createNewObject(cls);
		}
		
		if (cls == null) {
			return null;
		}
		
		if (!useColumn(cls)) {
			return null;
		}
		
		UseColumn useColumn = cls.getDeclaredAnnotation(UseColumn.class);
		String keyColumnName = useColumn.keyColum();
		String keyFieldName = useColumn.keyVarName();
		Class<?> keyFieldType = useColumn.keyType();
		
		boolean isMatchKeyData = false;
		
		if (keyFieldType != Object.class) {
			if (keyFieldType == String.class) {
				String keyData = getStringColumnValue(rs, keyColumnName);
				
				Field keyField = null;
				try {
					keyField = valueObject.getClass().getDeclaredField(keyFieldName);
					keyField.setAccessible(true);
					String keyValue = (String) getFieldValue(keyField, valueObject);
					
					if (keyData.equals(keyValue)) {
						makeOneRowDatas(rs, valueObject, cls);
						isMatchKeyData = true;
					}
				} catch (NoSuchFieldException | SecurityException e) {
					e.printStackTrace();
				}
			}
			else if (keyFieldType == int.class) {
				int keyData = getIntColumnValue(rs, keyColumnName);
				
				Field keyField = null;
				try {
					keyField = valueObject.getClass().getDeclaredField(keyFieldName);
					keyField.setAccessible(true);
					int keyValue = (int) getFieldValue(keyField, valueObject);
					
					if (keyData == keyValue) {
						makeOneRowDatas(rs, valueObject, cls);
						isMatchKeyData = true;
					}
				} catch (NoSuchFieldException | SecurityException e) {
					e.printStackTrace();
				}
			}
		}
		
		if (!isMatchKeyData) {
			valueObject = (T) makeOneRowDatas(rs, null, cls);
		}
		
		return valueObject;
	}
	
	public static <T> List<T> makeAllRowDatas(ResultSet rs, List<T> valueObject, Class<? extends Object> cls) {
		if (valueObject == null) {
			return null;
		}
		
		if (cls == null) {
			return null;
		}
		
		if (!useColumn(cls)) {
			return null;
		}
		
		UseColumn useColumn = cls.getDeclaredAnnotation(UseColumn.class);
		String keyColumnName = useColumn.keyColum();
		String keyFieldName = useColumn.keyVarName();
		Class<?> keyFieldType = useColumn.keyType();
		
		boolean isMatchKeyData = false;
		
		if (keyFieldType != Object.class) {
			if (keyFieldType == String.class) {
				String keyData = getStringColumnValue(rs, keyColumnName);
				
				for (T t : valueObject) {
					Field keyField = null;
					try {
						keyField = t.getClass().getDeclaredField(keyFieldName);
						keyField.setAccessible(true);
						String keyValue = (String) getFieldValue(keyField, t);
						
						if (keyData.equals(keyValue)) {
							makeOneRowDatas(rs, t, cls);
							isMatchKeyData = true;
							break;
						}
					} catch (NoSuchFieldException | SecurityException e) {
						e.printStackTrace();
					}
				}
			}
			else if (keyFieldType == int.class) {
				int keyData = getIntColumnValue(rs, keyColumnName);
				
				for (T t : valueObject) {
					Field keyField = null;
					try {
						keyField = t.getClass().getDeclaredField(keyFieldName);
						keyField.setAccessible(true);
						int keyValue = (int) getFieldValue(keyField, t);
						
						if (keyData == keyValue) {
							makeOneRowDatas(rs, t, cls);
							isMatchKeyData = true;
							break;
						}
					} catch (NoSuchFieldException | SecurityException e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		if (!isMatchKeyData) {
			valueObject.add((T) makeOneRowDatas(rs, null, cls));
		}
		
		return valueObject;
	}
	
	public static Object makeOneRowDatas(ResultSet rs, Object valueObject, Class<? extends Object> cls) {
		if (cls == null) {
			return null;
		}
		
		if (!useColumn(cls)) {
			return null;
		}
		
		Field[] fields = cls.getDeclaredFields();
		for (Field field : fields) {
			if (isRequire(field)) {
				String columnName = getColumnName(field);
				String value = getStringColumnValue(rs, columnName);
				if (value == null) {
					return null;
				}
			}
		}
		
		
		if (valueObject == null) {
			valueObject = createNewObject(cls);
		}
		
		for (Field field : fields) {
			field.setAccessible(true);
			Class<?> fieldClass = field.getDeclaringClass();
			if (fieldClass != ArrayList.class && fieldClass.getSuperclass() != Object.class) {
				makeOneRowDatas(rs, null, fieldClass.getSuperclass());
			}
			
			String columnName = getColumnName(field);
			if (field.getType() == String.class) {
				setValue(field, valueObject, getStringColumnValue(rs, columnName));
			}
			else if (field.getType() == int.class) {
				setValue(field, valueObject, getIntColumnValue(rs, columnName));
			}
			else if (field.getType() == List.class) {
				List list = (List) getFieldValue(field, valueObject);
				if (list == null) {
					list = new ArrayList<>();
					setValue(field, valueObject, list);
				}
				Object itemInList = makeOneRowDatas(rs, null, getClass(field));
				if (itemInList != null) {
					
					UseColumn useColumn = itemInList.getClass().getDeclaredAnnotation(UseColumn.class);
					String keyFieldName = useColumn.keyVarName();
					Class<?> keyFieldType = useColumn.keyType();
					
					boolean isDuplicate = false;
					if (keyFieldName != null) {
						if (keyFieldType == int.class) {
							int keyValue = getIntKeyValue(itemInList, keyFieldName);
							for (Object objInList : list) {
								int itemKeyValue = getIntKeyValue(objInList, keyFieldName);
								if (keyValue == itemKeyValue) {
									isDuplicate = true;
								}
							}
						}
						else if (keyFieldType == String.class) {
							String keyValue = getStringKeyValue(itemInList, keyFieldName);
							for (Object objInList : list) {
								String itemKeyValue = getStringKeyValue(objInList, keyFieldName);
								if (keyValue.equals(itemKeyValue)) {
									isDuplicate = true;
								}
							}
						}
						
					}
					
					if (!isDuplicate) {
						list.add(itemInList);
						setValue(field, valueObject, list);
					}
				}
			}
			else {
				Object subObj = makeOneRowDatas(rs, null, field.getType());
				if (subObj != null) {
					setValue(field, valueObject, subObj);
				}
			}
		}
		
		return valueObject;
	}
	
	private static int getIntKeyValue(Object obj, String keyFieldName) {
		try {
			Field keyField = obj.getClass().getDeclaredField(keyFieldName);
			return (int) getFieldValue(keyField, obj);
		} catch (NoSuchFieldException | SecurityException e) {
			return new Random().nextInt();
		}
	}
	
	private static String getStringKeyValue(Object obj, String keyFieldName) {
		try {
			Field keyField = obj.getClass().getDeclaredField(keyFieldName);
			return (String) getFieldValue(keyField, obj);
		} catch (NoSuchFieldException | SecurityException e) {
			return new Random().nextInt() + "";
		}
	}
	
	private static String getStringColumnValue(ResultSet rs, String columnName) {
		if (columnName.equals("_DUMMY_")) {
			return null;
		}
		try {
			return rs.getString(columnName);
		} catch (SQLException e) {
		}
		return null;
	}
	
	private static int getIntColumnValue(ResultSet rs, String columnName) {
		if (columnName.equals("_DUMMY_")) {
			return Integer.MIN_VALUE;
		}
		try {
			return rs.getInt(columnName);
		} catch (SQLException e) {
		}
		return Integer.MIN_VALUE;
	}
	
	private static Object getFieldValue(Field f, Object obj) {
		f.setAccessible(true);
		try {
			return f.get(obj);
		} catch (IllegalArgumentException | IllegalAccessException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	private static void setValue(Field f, Object obj, Object value) {
		
		if (value == null) {
			return;
		}
		
		f.setAccessible(true);
		try {
			f.set(obj, value);
		} catch (IllegalArgumentException | IllegalAccessException e) {
			e.printStackTrace();
		}
	}
	
	private static Object createNewObject(Class<? extends Object> cls) {
		try {
			Constructor<?> cons = cls.getDeclaredConstructors()[0];
			return cons.newInstance();
		} catch (InstantiationException | IllegalAccessException | IllegalArgumentException
				| InvocationTargetException | SecurityException e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage(), e);
		}
	}
	
	private static boolean useColumn(Class<? extends Object> cls) {
		return cls.isAnnotationPresent(UseColumn.class);
	}
	
	private static boolean isRequire(Field f) {
		f.setAccessible(true);
		if (!f.isAnnotationPresent(Column.class)) {
			return false;
		}
		Column column = f.getDeclaredAnnotation(Column.class);
		return column.isRequire();
	}
	
	private static String getColumnName(Field f) {
		f.setAccessible(true);
		if (!f.isAnnotationPresent(Column.class)) {
			return null;
		}
		Column column = f.getDeclaredAnnotation(Column.class);
		return column.value();
	}
	
	private static boolean isClass(Field f) {
		f.setAccessible(true);
		if (!f.isAnnotationPresent(Column.class)) {
			return false;
		}
		Column column = f.getDeclaredAnnotation(Column.class);
		return column.cls() != Object.class;
	}
	
	private static Class<?> getClass(Field f) {
		f.setAccessible(true);
		if (!isClass(f)) {
			return null;
		}
		if (!f.isAnnotationPresent(Column.class)) {
			return null;
		}
		
		Column column = f.getDeclaredAnnotation(Column.class);
		return column.cls();
	}
	
}
