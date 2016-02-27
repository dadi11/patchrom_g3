package android.widget;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class ArrayAdapter<T> extends BaseAdapter implements Filterable {
    private Context mContext;
    private int mDropDownResource;
    private int mFieldId;
    private ArrayFilter mFilter;
    private LayoutInflater mInflater;
    private final Object mLock;
    private boolean mNotifyOnChange;
    private List<T> mObjects;
    private ArrayList<T> mOriginalValues;
    private int mResource;

    private class ArrayFilter extends Filter {
        private ArrayFilter() {
        }

        protected FilterResults performFiltering(CharSequence prefix) {
            FilterResults results = new FilterResults();
            if (ArrayAdapter.this.mOriginalValues == null) {
                synchronized (ArrayAdapter.this.mLock) {
                    ArrayAdapter.this.mOriginalValues = new ArrayList(ArrayAdapter.this.mObjects);
                }
            }
            if (prefix == null || prefix.length() == 0) {
                ArrayList<T> list;
                synchronized (ArrayAdapter.this.mLock) {
                    list = new ArrayList(ArrayAdapter.this.mOriginalValues);
                }
                results.values = list;
                results.count = list.size();
            } else {
                ArrayList<T> values;
                String prefixString = prefix.toString().toLowerCase();
                synchronized (ArrayAdapter.this.mLock) {
                    values = new ArrayList(ArrayAdapter.this.mOriginalValues);
                }
                int count = values.size();
                ArrayList<T> newValues = new ArrayList();
                for (int i = 0; i < count; i++) {
                    T value = values.get(i);
                    String valueText = value.toString().toLowerCase();
                    if (valueText.startsWith(prefixString)) {
                        newValues.add(value);
                    } else {
                        for (String startsWith : valueText.split(" ")) {
                            if (startsWith.startsWith(prefixString)) {
                                newValues.add(value);
                                break;
                            }
                        }
                    }
                }
                results.values = newValues;
                results.count = newValues.size();
            }
            return results;
        }

        protected void publishResults(CharSequence constraint, FilterResults results) {
            ArrayAdapter.this.mObjects = (List) results.values;
            if (results.count > 0) {
                ArrayAdapter.this.notifyDataSetChanged();
            } else {
                ArrayAdapter.this.notifyDataSetInvalidated();
            }
        }
    }

    public ArrayAdapter(Context context, int resource) {
        this.mLock = new Object();
        this.mFieldId = 0;
        this.mNotifyOnChange = true;
        init(context, resource, 0, new ArrayList());
    }

    public ArrayAdapter(Context context, int resource, int textViewResourceId) {
        this.mLock = new Object();
        this.mFieldId = 0;
        this.mNotifyOnChange = true;
        init(context, resource, textViewResourceId, new ArrayList());
    }

    public ArrayAdapter(Context context, int resource, T[] objects) {
        this.mLock = new Object();
        this.mFieldId = 0;
        this.mNotifyOnChange = true;
        init(context, resource, 0, Arrays.asList(objects));
    }

    public ArrayAdapter(Context context, int resource, int textViewResourceId, T[] objects) {
        this.mLock = new Object();
        this.mFieldId = 0;
        this.mNotifyOnChange = true;
        init(context, resource, textViewResourceId, Arrays.asList(objects));
    }

    public ArrayAdapter(Context context, int resource, List<T> objects) {
        this.mLock = new Object();
        this.mFieldId = 0;
        this.mNotifyOnChange = true;
        init(context, resource, 0, objects);
    }

    public ArrayAdapter(Context context, int resource, int textViewResourceId, List<T> objects) {
        this.mLock = new Object();
        this.mFieldId = 0;
        this.mNotifyOnChange = true;
        init(context, resource, textViewResourceId, objects);
    }

    public void add(T object) {
        synchronized (this.mLock) {
            if (this.mOriginalValues != null) {
                this.mOriginalValues.add(object);
            } else {
                this.mObjects.add(object);
            }
        }
        if (this.mNotifyOnChange) {
            notifyDataSetChanged();
        }
    }

    public void addAll(Collection<? extends T> collection) {
        synchronized (this.mLock) {
            if (this.mOriginalValues != null) {
                this.mOriginalValues.addAll(collection);
            } else {
                this.mObjects.addAll(collection);
            }
        }
        if (this.mNotifyOnChange) {
            notifyDataSetChanged();
        }
    }

    public void addAll(T... items) {
        synchronized (this.mLock) {
            if (this.mOriginalValues != null) {
                Collections.addAll(this.mOriginalValues, items);
            } else {
                Collections.addAll(this.mObjects, items);
            }
        }
        if (this.mNotifyOnChange) {
            notifyDataSetChanged();
        }
    }

    public void insert(T object, int index) {
        synchronized (this.mLock) {
            if (this.mOriginalValues != null) {
                this.mOriginalValues.add(index, object);
            } else {
                this.mObjects.add(index, object);
            }
        }
        if (this.mNotifyOnChange) {
            notifyDataSetChanged();
        }
    }

    public void remove(T object) {
        synchronized (this.mLock) {
            if (this.mOriginalValues != null) {
                this.mOriginalValues.remove(object);
            } else {
                this.mObjects.remove(object);
            }
        }
        if (this.mNotifyOnChange) {
            notifyDataSetChanged();
        }
    }

    public void clear() {
        synchronized (this.mLock) {
            if (this.mOriginalValues != null) {
                this.mOriginalValues.clear();
            } else {
                this.mObjects.clear();
            }
        }
        if (this.mNotifyOnChange) {
            notifyDataSetChanged();
        }
    }

    public void sort(Comparator<? super T> comparator) {
        synchronized (this.mLock) {
            if (this.mOriginalValues != null) {
                Collections.sort(this.mOriginalValues, comparator);
            } else {
                Collections.sort(this.mObjects, comparator);
            }
        }
        if (this.mNotifyOnChange) {
            notifyDataSetChanged();
        }
    }

    public void notifyDataSetChanged() {
        super.notifyDataSetChanged();
        this.mNotifyOnChange = true;
    }

    public void setNotifyOnChange(boolean notifyOnChange) {
        this.mNotifyOnChange = notifyOnChange;
    }

    private void init(Context context, int resource, int textViewResourceId, List<T> objects) {
        this.mContext = context;
        this.mInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        this.mDropDownResource = resource;
        this.mResource = resource;
        this.mObjects = objects;
        this.mFieldId = textViewResourceId;
    }

    public Context getContext() {
        return this.mContext;
    }

    public int getCount() {
        return this.mObjects.size();
    }

    public T getItem(int position) {
        return this.mObjects.get(position);
    }

    public int getPosition(T item) {
        return this.mObjects.indexOf(item);
    }

    public long getItemId(int position) {
        return (long) position;
    }

    public View getView(int position, View convertView, ViewGroup parent) {
        return createViewFromResource(position, convertView, parent, this.mResource);
    }

    private View createViewFromResource(int position, View convertView, ViewGroup parent, int resource) {
        View view;
        if (convertView == null) {
            view = this.mInflater.inflate(resource, parent, false);
        } else {
            view = convertView;
        }
        try {
            TextView text;
            if (this.mFieldId == 0) {
                text = (TextView) view;
            } else {
                text = (TextView) view.findViewById(this.mFieldId);
            }
            T item = getItem(position);
            if (item instanceof CharSequence) {
                text.setText((CharSequence) item);
            } else {
                text.setText(item.toString());
            }
            return view;
        } catch (ClassCastException e) {
            Log.e("ArrayAdapter", "You must supply a resource ID for a TextView");
            throw new IllegalStateException("ArrayAdapter requires the resource ID to be a TextView", e);
        }
    }

    public void setDropDownViewResource(int resource) {
        this.mDropDownResource = resource;
    }

    public View getDropDownView(int position, View convertView, ViewGroup parent) {
        return createViewFromResource(position, convertView, parent, this.mDropDownResource);
    }

    public static ArrayAdapter<CharSequence> createFromResource(Context context, int textArrayResId, int textViewResId) {
        return new ArrayAdapter(context, textViewResId, context.getResources().getTextArray(textArrayResId));
    }

    public Filter getFilter() {
        if (this.mFilter == null) {
            this.mFilter = new ArrayFilter();
        }
        return this.mFilter;
    }
}
